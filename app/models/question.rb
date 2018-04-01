class Question < ApplicationRecord
    paginates_per 5
    has_many :answers
    #has_many :loghistories
end
