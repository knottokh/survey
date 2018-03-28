class School < ApplicationRecord
    
    has_many :users
    has_many :answers, through: :users
end
