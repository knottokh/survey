class Question < ApplicationRecord
    paginates_per 5
    has_many :answers
    belongs_to :musicin
    #has_many :loghistories
end
