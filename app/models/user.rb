class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable
  
  has_many :messages, foreign_key: :sender_id
end
