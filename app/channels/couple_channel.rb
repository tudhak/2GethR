class CoupleChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"

    couple = Couple.find(params[:id])
    stream_for couple
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
