class DailyQuiz < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :quiz_attempts
end
