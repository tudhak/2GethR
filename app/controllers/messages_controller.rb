class MessagesController < ApplicationController
  def create
    @couple = Couple.find(params[:couple_id])
    @message = Message.new(message_params)
    @message.couple = @couple
    @message.user = current_user
    if @message.save
      CoupleChannel.broadcast_to(
        @couple,
        render_to_string(partial: "message", locals: { message: @message })
      )
      head :ok
      # redirect_to couple_path(@couple)
    else
      render "couples/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
