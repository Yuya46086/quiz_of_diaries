class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :posts
         has_many :daily_quizzes
         has_many :quiz_attempts
end
