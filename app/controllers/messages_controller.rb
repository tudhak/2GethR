class MessagesController < ApplicationController
  def create
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
end
