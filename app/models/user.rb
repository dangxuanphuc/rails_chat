class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_many :sender_messages, class_name: Message.name, foreign_key: :sender_id
  has_many :recipient_messages, class_name: Message.name, foreign_key: :recipient_id

  after_update_commit :appearance_broadcast

  def set_online_time
    start_time = Time.now
    if self.online_at.nil?
      active_at = ""
    else
      end_time = self.online_at.to_time
      if start_time && end_time
        time_sub = time_diff(start_time, end_time)
        if time_sub >= 86400
          timer = ((time_sub / 86400).to_i).to_s + "d"
        elsif time_sub < 86400 && time_sub >= 3600
          timer = ((time_sub / 3600).to_i).to_s + "h"
        elsif time_sub < 3600 && time_sub >= 60
          timer = ((time_sub / 60).to_i).to_s + "m"
        else
          timer = (time_sub).to_s + "s"
        end
      end
      active_at = "Active " + timer + " ago"
    end
  end

  class << self
    attr_accessor :current_user
  end

  private

  def appearance_broadcast
    AppearanceBroadcastJob.perform_later(self)
  end

  def time_diff start_time, end_time
    (start_time - end_time).round
  end
end
