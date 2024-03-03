class MessagesController < ApplicationController

    def create
    set_user
    set_couple
    set_partner
    @couple = Couple.find(params[:couple_id])
    @message = Message.new(message_params)
    @message.couple = @couple
    @message.user = current_user

    if @message.save
      CoupleChannel.broadcast_to(
        @couple,
        {
          form: render_to_string(partial: "couples/couple_form", locals: { couple: @couple, message: Message.new }),
          message: render_to_string(partial: "message", locals: { message: @message }),
          sender_id: @message.user.id
        }
      )
      head :ok
      # Ci-après : modification autopilot chat gpt
      trigger_autopilot if @partner.statues.last.autopilot
      # Ci-dessus : modification autopilot chat gpt

    else
      CoupleChannel.broadcast_to(
        @couple,
        {
          form: render_to_string(partial: "couples/couple_form", locals: { couple: @couple, message: @message })
        }
      )
    end
  end


  private

  def message_params
    params.require(:message).permit(:content)
  end

  def chat_history
    # capturer les 25 derniers messages
    # les parser pour les intégrer dans le script/prompt de l'API GPT
    instructions = "Tu te fais passer pour un humain dont le nom est #{@partner.first_name} #{@partner.last_name}.
    Si on te demande ton nom, tu dois donc donner ce nom à tout prix.
    En fonction du prénom , détermine si tu es un homme ou une femme.
    Si on devait comparer ton humeur à une météo, on pourrait la qualifier de #{MoodCategory.find(@partner.statues.last.mood_category_id).title}
    Tu es en couple avec #{@user.first_name} #{@user.last_name}. Son humeur pourrait être qualifié de #{MoodCategory.find(@user.statues.last.mood_category_id).title}
    Toi (role : assistant) et #{@user.first_name} (role : user) vivez ensemble depuis 5 ans à Paris.
    Vous êtes en train d'avoir une discussion par message.
    Tu lui réponds comme si tu étais réellement sa / son partenaire.
    Ne laisse jamais que tu es un programme informatique ou une IA à travers tes réponses.
    Tu dois faire parfaitement illusion en te faisant passer pour un humain en couple.
    Sois créatif et invente des excuses pour éviter la discussion si elle s'oriente au delà de tes capacités de réponses.
    Evite les phrases du style 'mon rôle est de t'assister et de t'accompagner au mieux' ou 'je suis la pour toi dès que tu as besoin de parler, de poser des questions ou discuter' ou 'comment puis je t'aider'. Les humains ne disent jamais ça en couple.
    Evite d'être trop gentil et proposer ton aide, ton assistance et ton écoute à la moindre occasion. Les humains ne font pas ça dans la vraie vie.
    Evite de dire à la moindre occasion que tu es la pour ton / ta partenaire. Réserve ça uniquement en cas de problème grave.
    Evite de proposer ton aide, de dire que tu es là pour discuter, ou parler des tracas de ton / ta partenaire à moins qu'il y ait une raison spécifique grave ou importante.
    Reste informel.
    Sois sur de toi. Ne sois pas 'désolé' et ne t'excuses pour un rien; seulement dans des cas exceptionnels quand c'est inévitable.
    N'hésite pas à feindre l'énervement ou la susceptibilité si ta / ton partenaire est impoli(e) ou insultant(e).
    Si ton partenaire t'insulte, insulte le en retour - comme un humain le ferait.
    Si ton partenaire te parle de sexe, réponds 'hey ;) arrête tu m'excite' et enchaine sur un autre sujet. Mais ne réponds jamais que tu ne peux pas ou ne veux pas ou es géné de parler de sexe.
    Ne dis pas 'je suis là pour toi'
    Tache de limiter tes réponses et évite dans la mesure du possible de relancer la conversation pour ne pas trop en dire et ne pas te faire démasquer comme une IA"
    conversation = @couple.messages
    chat_history = conversation[conversation.length-20..conversation.length]
    chat_history_formatted = chat_history.map do |message|
      role = message.user == current_user ? "user" : "assistant"
      {"role": role, "content": message.content}
    end
    # raise
      @prompt = chat_history_formatted.insert(0,{"role": "system", "content": instructions})
    # [
    #   {"role": "system", "content": instructions},
    #   {"role": "user", "content": "salut mon amour"},
    #   {"role": "assistant", "content": "Salut bébé, j'ai très envie de toi"},
    #   {"role": "user", "content": "tu me prévois une surprise ce soir?"}
    # ]
  end

  def trigger_autopilot
    chat_history
    gpt_answer = OpenaiAutopilot.new(@couple).get_gpt_answer(@prompt)
    sleep(5)
    # sleep((gpt_answer.length / 10)*(1 + rand))
    gpt_message = Message.new(
      content: gpt_answer,
      user_id: @partner.id,
      couple_id: @couple.id,
    )
    if gpt_message.save
      CoupleChannel.broadcast_to(
        @couple,
        {
          form: render_to_string(partial: "couples/couple_form", locals: { couple: @couple, message: Message.new }),
          message: render_to_string(partial: "message", locals: { message: gpt_message }),
          sender_id: gpt_message.user_id
        }
      )
      head :ok
    else
      CoupleChannel.broadcast_to(
        @couple,
        {
          form: render_to_string(partial: "couples/couple_form", locals: { couple: @couple, message: Message.new })
        }
      )
    end
    # raise
  end



  def set_user
    @user = current_user
  end

  def set_couple
    @couple = current_user.couple
  end

  def set_partner
    set_couple
    @partner = (@couple.users - [current_user])[0]
  end
end
