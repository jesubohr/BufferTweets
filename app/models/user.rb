# email: string
# password_digest: string
# password: string virtual
# password_confirmation: string virtual
class User < ApplicationRecord
  has_many :twitter_accounts, dependent: :destroy

  has_secure_password

  validates :email, presence: true, uniqueness: true, format: {
    with: /\A[^@\s]+@[^@\s]+\z/,
    message: 'Must be a valid email address'
  }

  validates :password, presence: true, length: { minimum: 8, maximum: 32 }, format: {
    with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,32}\z/,
    message: 'Must contain at least one uppercase letter, one lowercase letter, and one number'
  }

  validates :password_confirmation, presence: true
end
