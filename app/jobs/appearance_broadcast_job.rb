class AppearanceBroadcastJob < ApplicationJob
  queue_as :default

  def perform user
    ActionCable.server.broadcast "appearance_user", user: render_json(user), time: user.set_online_time
  end

  private

  def render_json user
    ApplicationController.renderer.render(json: user)
  end
end
