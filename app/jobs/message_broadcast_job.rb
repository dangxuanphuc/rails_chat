class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform message
    sender = message.sender
    recipient = message.recipient

    broadcast_to_sender(sender, message)
    broadcast_to_recipient(recipient, message)
  end

  private

  def broadcast_to_sender user, message
    ActionCable.server.broadcast(
      "conversation-with-user-#{user.id}",
      message: render_message(message),
      sender_id: message.sender_id,
      recipient_id: message.recipient_id
    )
  end

  def broadcast_to_recipient user, message
    ActionCable.server.broadcast(
      "conversation-with-user-#{user.id}",
      message: render_message(message),
      sender_id: message.sender_id,
      recipient_id: message.recipient_id
    )
  end

  # Error current_user: ???
  def render_message message
    ApplicationController.render(
      partial: "messages/message",
      locals: { message: message, current_user: message.sender }
    )
  end
end
