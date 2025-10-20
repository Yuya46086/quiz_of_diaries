class Post < ApplicationRecord
  belongs_to :user
  has_one :daily_quiz, dependent: :destroy

  accepts_nested_attributes_for :daily_quiz
end
