class CreateUserSentenceSets < ActiveRecord::Migration[7.0]
  def change
    create_table :user_sentence_sets do |t|
      t.string :title
      t.text :description
      t.string :category
      t.integer :access, default: 1
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
