class AddAlternateAnswersToDailyQuizzes < ActiveRecord::Migration[7.1]
  def change
    add_column :daily_quizzes, :alternate_answers, :string
  end
end
