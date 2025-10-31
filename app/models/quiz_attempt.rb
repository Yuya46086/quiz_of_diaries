class QuizAttempt < ApplicationRecord
  belongs_to :user
  belongs_to :daily_quiz

  def calculate_score
    return 0 unless is_correct
    post_date = daily_quiz.post.post_date
    days_passed = (Time.zone.today - post_date.to_date).to_i
    [1, days_passed].max
  rescue
    1
  end
end
