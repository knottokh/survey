class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :recoverable,:confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
          :rememberable, :trackable, :validatable
         
  belongs_to :role
  
  validates :username,presence: true, length:{minimum:5}, uniqueness: true
  validates :school,presence: true
  
  before_create :set_default_role
  # or 
  # before_validation :set_default_role 
  def email_required?
    false
  end

  def email_changed?
    false
  end
  
  # use this instead of email_changed? for rails >= 5.1
  def will_save_change_to_email?
    false
  end
  
  private
  def set_default_role
    self.role ||= Role.find_by_name('user')
  end
end
