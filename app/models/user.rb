class User < ApplicationRecord
	has_secure_password
   
	has_many :stocks, dependent: :destroy

	validates :username, presence: true, length: { in: 2..50 }
	validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Invalid email' }
	validates :password, confirmation: true, unless: -> { password.blank? }

end
