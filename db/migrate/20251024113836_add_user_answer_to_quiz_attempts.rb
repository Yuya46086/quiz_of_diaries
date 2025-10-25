class AddUserAnswerToQuizAttempts < ActiveRecord::Migration[7.1]
  def change
    add_column :quiz_attempts, :user_answer, :string, null: false
  end
end
