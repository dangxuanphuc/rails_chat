class ConversationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "conversation-with-user-#{params['sender_id']}"
  end

  def unsubscribed
    stop_all_streams
  end

  def speak data
    message_params = data["message"].each_with_object({}) do |el, hash|
      hash[el.values.first] = el.values.last
    end

    # current_user.messages.build message_params
    ActionCable.server.broadcast(
      "conversation-with-user-#{params['sender_id']}",
      message: message_params,
      sender_id: current_user.id
    )
  end
end
