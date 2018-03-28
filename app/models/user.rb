class User < ApplicationRecord

  validates :username,length: {minimum: 5}, uniqueness: true
  has_secure_password
  validates :school_id, presence: true
  
  belongs_to :school
  has_many :loghistories
end

