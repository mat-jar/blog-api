class CreateUserSentences < ActiveRecord::Migration[7.0]
  def change
    create_table :user_sentences do |t|
      t.string :sentence
      t.string :key_word
      t.string :hint
      t.string :comment
      t.references :user_sentence_set, null: false, foreign_key: true

      t.timestamps
    end
  end
end
