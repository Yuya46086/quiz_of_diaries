class AddScoreAwardedToQuizAttempts < ActiveRecord::Migration[7.1]
  def change
    add_column :quiz_attempts, :score_awarded, :integer, default: 0
  end
end
