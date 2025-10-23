class QuizAttempt < ApplicationRecord
  belongs_to :user
  belongs_to :daily_quiz
end
