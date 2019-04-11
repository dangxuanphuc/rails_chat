class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    user = User.where(id: current_user.id).first

    return unless user
    user.update_attributes online: true
    stream_from "appearance_user"
  end

  def unsubscribed
    user = User.where(id: current_user.id).first

    return unless user
    user.update_attributes online: false
  end
end
