class User < ActiveRecord::Base
  #BCrypt is used to store hashed passwords and authenticate users
  validates :name, :email, :password, presence: true
  validates :name, :email, uniqueness: true
  validates :password, length: { minimum: 6}
end
