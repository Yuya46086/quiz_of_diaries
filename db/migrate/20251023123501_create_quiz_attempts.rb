class CreateQuizAttempts < ActiveRecord::Migration[7.1]
  def change
    create_table :quiz_attempts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :daily_quiz, null: false, foreign_key: true
      t.boolean :is_correct, null: false
      t.date :attempt_date, null: false
      t.integer :question_order, null: false

      t.timestamps
    end
  end
end
