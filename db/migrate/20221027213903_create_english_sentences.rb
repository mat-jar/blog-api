class CreateEnglishSentences < ActiveRecord::Migration[7.0]
  def change
    create_table :english_sentences do |t|
      t.string :sentence
      t.string :word

      t.timestamps
    end
  end
end
