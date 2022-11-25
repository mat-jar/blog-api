class RenameWordToKeyWordInEnglishSentences < ActiveRecord::Migration[7.0]
  def change
    rename_column :english_sentences, :word, :key_word
  end
end
