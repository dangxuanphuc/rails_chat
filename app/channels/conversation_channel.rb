class ConversationChannel < ApplicationCable::Channel
  def subscribed
    suffix_str = [params['user_id'].to_i, current_user.id].sort.join("-")
    stream_from "conversation-with-user-#{suffix_str}"
  end

  def unsubscribed
    stop_all_streams
  end

  def speak data
    Message.create(body: data["message"], recipient_id: data["user_id"], sender_id: current_user.id)
  end
end
