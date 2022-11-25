class RemoveFlashcardSetFromLearningSessions < ActiveRecord::Migration[7.0]
  def change
    remove_reference :learning_sessions, :flashcard_set, null: false, foreign_key: true
  end
end
