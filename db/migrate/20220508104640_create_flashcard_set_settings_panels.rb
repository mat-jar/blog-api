class CreateFlashcardSetSettingsPanels < ActiveRecord::Migration[7.0]
  def change
    create_table :flashcard_set_settings_panels do |t|
      t.references :user, null: false, foreign_key: true
      t.references :flashcard_set, null: false, foreign_key: true
      t.references :resume_flashcard, null: false, foreign_key: { to_table: :flashcards }
      t.boolean :shuffle
      t.boolean :alphabetize
      t.boolean :front_first
      t.boolean :read
      t.integer :mode
      t.integer :answer_type
      t.integer :answer_ignore

      t.timestamps
    end
    #add_foreign_key :flashcard_set_settings_panels, :flashcards, column: :resume_flashcard
  end

end
