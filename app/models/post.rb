class Post < ApplicationRecord
  belongs_to :user
  has_one :daily_quiz
end
