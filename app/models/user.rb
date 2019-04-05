class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable
  
  has_many :sender_messages, class_name: Message.name, foreign_key: :sender_id
  has_many :recipient_messages, class_name: Message.name, foreign_key: :recipient_id
end
