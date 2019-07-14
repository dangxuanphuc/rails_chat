class Message < ApplicationRecord
  belongs_to :recipient, class_name: User.name, foreign_key: :recipient_id
  belongs_to :sender, class_name: User.name, foreign_key: :sender_id

  after_create_commit :message_broadcast

  scope :filter_by_recipient_and_sender, -> (sender_id, recipient_id) do
    where(sender_id: sender_id, recipient_id: recipient_id).or(
      where(sender_id: recipient_id, recipient_id: sender_id)
    )
  end

  validates :body, presence: true

  private

  def message_broadcast
    MessageBroadcastJob.perform_later(self)
  end
end
