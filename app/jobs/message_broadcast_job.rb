class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform message
    recipient = message.recipient
    broadcast_to_user(message, recipient)
  end

  private

  def broadcast_to_user message, user
    suffix_str = [message.sender.id, message.recipient.id].sort.join("-")
    ActionCable.server.broadcast(
      "conversation-with-user-#{suffix_str}",
      message: render_message(message),
      message_id: message.id,
      sender_id: message.sender_id
    )
  end

  def render_message message
    ApplicationController.render(
      partial: "messages/message",
      locals: { message: message }
    )
  end
end
