class User < ApplicationRecord

  validates :username,length: {minimum: 5}, uniqueness: true
  has_secure_password
  validates :school, presence: true
end
