class MessagesController < ApplicationController
  respond_to :json
  def create
    @message = Message.new(params[:message])
    if @message.valid?
      @message.deliver(current_user)
      render :json => @message
    else
      respond_with @message
    end
  end
end
