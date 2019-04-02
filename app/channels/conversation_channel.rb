class ConversationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "conversation-with-user-#{params['user_id']}-channel"
  end

  def unsubscribed
    stop_all_streams
  end

  def speak data
    message_params = data["message"].each_with_object({}) do |el, hash|
      hash[el.values.first] = el.values.last
    end

    current_user.messages.create(message_params)
  end
end
