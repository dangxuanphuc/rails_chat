class ConversationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "conversation-with-user-#{params['user_id']}"
  end

  def unsubscribed
    stop_all_streams
  end

  def speak data
    Message.create(body: data["message"], recipient_id: data["user_id"], sender_id: current_user.id)
  end
end
