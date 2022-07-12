class User < ApplicationRecord
	has_secure_password
   
	has_many :stocks, dependent: :delete_all

	validates :username, presence: true, length: { in: 4..50 }
	mail_validation = /\A[^@\s]+@[^@\s]+\z/
	validates :email, presence: true, uniqueness: true, format: { with: mail_validation, message: 'Invalid email' }
	password_validation = /\A(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}\z/
	validates :password, confirmation: true, format: { with: password_validation, message: 'Minimum eight characters, at least one letter, one number and one special character' }, unless: -> { password.blank? }

end
