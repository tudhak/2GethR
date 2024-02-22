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
    @chat_history = []
  end

  def trigger_autopilot
    gpt_answer = OpenaiAutopilot.new.get_gpt_answer(@chat_history)
    gpt_message = Message.new(
      content: gpt_answer,
      user_id: @partner,
      couple_id: @couple,
    )
    if gpt_message.save
      CoupleChannel.broadcast_to(
        @couple,
        {
          form: render_to_string(partial: "couples/couple_form", locals: { couple: @couple, message: Message.new }),
          message: render_to_string(partial: "message", locals: { message: gpt_message }),
          sender_id: @partner
        }
      )
      head :ok
    else
      CoupleChannel.broadcast_to(
        @couple,
        {
          form: render_to_string(partial: "couples/couple_form", locals: { couple: @couple, message: gpt_message })
        }
      )
    end

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
