class User < ApplicationRecord

  validates :username,length: {minimum: 5}, uniqueness: true
  has_secure_password
  validates :school_id, presence: true
  validates :name, presence: true
  validates :lastname, presence: true
  validates :cardnumber, presence: true, length: {minimum: 13, maximum: 13}, format: { with: /\A[+-]?\d+?(_?\d+)*(\.\d+e?\d*)?\Z/, message: "accept Number only." }
  validates :position, presence: true
  validates :phone, presence: true , format: { with: /\A[+-]?\d+?(_?\d+)*(\.\d+e?\d*)?\Z/, message: "accept Number only." }
  validates :email, presence: true, uniqueness: true
  
  
  belongs_to :school
  belongs_to :role
  has_many :loghistories
end

