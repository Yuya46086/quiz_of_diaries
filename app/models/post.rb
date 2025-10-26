class Post < ApplicationRecord
  belongs_to :user
  has_one :daily_quiz, dependent: :destroy

  validates :post_date, presence: true
  validates :content, presence: true

  accepts_nested_attributes_for :daily_quiz
end
