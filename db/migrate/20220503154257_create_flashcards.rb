class CreateFlashcards < ActiveRecord::Migration[7.0]
  def change
    create_table :flashcards do |t|
      t.text :front_text
      t.text :back_text
      t.string :front_photo
      t.string :back_photo
      t.string :front_audio
      t.string :back_audio
      t.text :hint
      t.references :flashcard_set, null: false, foreign_key: true
      t.timestamps
    end
  end
end
