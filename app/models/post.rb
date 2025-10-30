class Post < ApplicationRecord
  belongs_to :user
  has_one :daily_quiz, dependent: :destroy
  has_one_attached :photo

  validates :post_date, presence: true
  validates :content, presence: true
  validates :photo, presence: true

  accepts_nested_attributes_for :daily_quiz
end
