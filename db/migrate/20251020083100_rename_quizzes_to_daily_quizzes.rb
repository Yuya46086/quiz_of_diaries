class RenameQuizzesToDailyQuizzes < ActiveRecord::Migration[7.1]
  def change
    rename_table :quizzes, :daily_quizzes
  end
end
