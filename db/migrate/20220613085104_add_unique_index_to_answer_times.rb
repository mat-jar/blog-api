class AddUniqueIndexToAnswerTimes < ActiveRecord::Migration[7.0]
  def change
    add_index :answer_times, [:flashcard_id, :round, :learning_session_id], unique: true, name: 'answer_times_unique_index'
  end
end
