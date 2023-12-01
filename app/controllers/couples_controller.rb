class CouplesController < ApplicationController
  def index
  end

  def show
    @couple = Couple.find(params[:id])
    @message = Message.new
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
