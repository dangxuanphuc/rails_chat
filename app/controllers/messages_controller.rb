class MessagesController < ApplicationController
  def index
    @users = User.where.not(id: current_user.id)
    # @user = User.find_by id: params[:user_id]
    
    # binding.pry
    
  end

  def create
    @user = User.find_by id: 2

    @message = @user.message.build message_params

    respond_to do |format|
      format.js
    end
  end

  private

  def message_params
    params.require(:message).permit :sender_id, :recipient_id, :body
  end
end
