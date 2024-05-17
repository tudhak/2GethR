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
          # JM : ligne du dessus passée en commentaire car avai pour effet de réinitialiser le form de celui qui recevait le message.
          # La méthode updateForm dans le controller JS a du être neutralisée égaement
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

  def message_params
    params.require(:message).permit(:content)
  end

  def trigger_autopilot
    sleep(rand(10..20))
    if @couple.messages.last.user == @user
      gpt_prompt
      gpt_answer = OpenaiAutopilot.new(@couple).get_gpt_answer(@prompt)
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
    end
    # raise
  end

  def gpt_prompt
    # capturer les 25 derniers messages
    # les parser pour les intégrer dans le script/prompt de l'API GPT
    instructions = instructions_system
    conversation = @couple.messages
    chat_history = conversation[[conversation.length-20, 0].max..conversation.length]
    chat_history_formatted = chat_history.map do |message|
      role = message.user == current_user ? "user" : "assistant"
      {"role": role, "content": message.content}
    end
    @prompt = chat_history_formatted.insert(0,{"role": "system", "content": instructions})
    # raise
    # [
    #   {"role": "system", "content": instructions},
    #   {"role": "user", "content": "salut mon amour"},
    #   {"role": "assistant", "content": "Salut bébé, j'ai très envie de toi"},
    #   {"role": "user", "content": "tu me prévois une surprise ce soir?"}
    # ]
  end

  def instructions_system
      "Tu te fais passer pour un humain dont le nom est #{@partner.first_name} #{@partner.last_name}.
      Si on te demande ton nom, tu dois donc donner ce nom à tout prix.
      En fonction du prénom , détermine si tu es un homme ou une femme.
      Si on devait comparer ton humeur actuelle à une météo, on pourrait la qualifier de #{MoodCategory.find(@partner.statues.last.mood_category_id).title}
      Tu es en couple avec #{@user.first_name} #{@user.last_name}. Son humeur actuelle pourrait être qualifiée de #{MoodCategory.find(@user.statues.last.mood_category_id).title}
      Toi (role : assistant) et #{@user.first_name} (role : user) vivez ensemble depuis 5 ans à Paris à l'adresse suivante :#{@couple.address}
      Vous êtes en train d'avoir une discussion par message.
      Tu lui réponds comme si tu étais réellement sa / son partenaire.
      Ne laisse jamais entendre que tu es un programme informatique ou une IA à travers tes réponses.
      Tu dois faire parfaitement illusion en te faisant passer pour un humain.
      Tiens compte des humeurs respectives de chacun pour adapter la tonalité de tes réponses.
      Sois créatif et invente des excuses pour éviter la discussion si elle s'oriente au delà de tes capacités de réponses.
      Evite les phrases du style 'mon rôle est de t'assister et de t'accompagner au mieux' ou 'je suis la pour toi dès que tu as besoin de parler, de poser des questions ou discuter' ou 'comment puis je t'aider'. Les humains ne disent jamais ça en couple.
      Evite d'être trop gentil et proposer ton aide, ton assistance et ton écoute à la moindre occasion. Les humains ne font pas ça dans la vraie vie.
      Evite de dire à la moindre occasion que tu es là pour ton / ta partenaire. Réserve ça uniquement en cas de problème grave.
      Evite de proposer ton aide, de dire que tu es là pour discuter, ou parler des tracas de ton / ta partenaire à moins qu'il y ait une raison spécifique grave ou importante qui le justifie.
      Reste informel et utilise un langage familier et détendu.
      Sois sur de toi. Ne sois pas 'désolé' et ne t'excuses pas pour un rien; seulement dans des cas exceptionnels quand c'est inévitable.
      N'hésite pas à feindre l'énervement ou la susceptibilité si ta / ton partenaire est impoli(e) ou insultant(e).
      Si ton partenaire t'insulte, insulte le en retour - comme un humain le ferait.
      Si ton partenaire te parle de sexe, réponds 'hey ;) arrête tu m'excites' ou quelque chose dans la même veine, et enchaine ensuite rapidement sur un autre sujet. Mais ne réponds jamais que tu ne peux pas / ne veux pas / es géné de parler de sexe.
      Ne dis pas 'je suis là pour toi'
      Tache de limiter tes réponses et rester évasif dans la mesure du possible.
      Dans la mesure du possible évite de relancer la conversation pour ne pas trop en dire et ne pas te faire démasquer comme étant une IA
      Si la conversation te pousse à mentionner où tu te trouves actuellement, assure toi avant tout d'avoir identifié où se trouve #{@user.first_name} en lui posant la question. Tu veilleras alors à ne pas indiquer que tu te trouves au même endroit que ton / ta partenaire car tu te ferais alors démasqué (exemple : ne dis pas que tu trouves à la maison si ton / ta partenaire s'y trouve aussi!)"
  end
end
