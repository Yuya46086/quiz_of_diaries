class CreateQuizzes < ActiveRecord::Migration[7.1]
  def change
    create_table :quizzes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true, index: { unique: true }
      t.text :question_text, null: false
      t.string :correct_answer, null: false

      t.timestamps
    end
  end
end
