class DailyQuiz < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :quiz_attempts, dependent: :destroy

  validates :question_text, presence: true
  validates :correct_answer, presence: true
end
