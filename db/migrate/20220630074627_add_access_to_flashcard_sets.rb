class AddAccessToFlashcardSets < ActiveRecord::Migration[7.0]
  def change
    add_column :flashcard_sets, :access, :integer, default: 0
  end
end
