class MessagesController < ApplicationController
  def index
    if params[:user_id].present?
      @messages = Message.filter_by_recipient_and_sender(params[:user_id], current_user.id)

      @user = User.find_by id: params[:user_id]
      @users = User.where.not(id: current_user.id)
    else
      @users = User.where.not(id: current_user.id)
      @messages_first = Message.filter_by_recipient_and_sender(@users.first, current_user.id)
    end
  end
end
