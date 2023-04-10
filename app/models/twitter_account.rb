class TwitterAccount < ApplicationRecord
  belongs_to :user

  validates :username, presence: true, uniqueness: { scope: :user_id }
end
