class CreateLearningSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :learning_sessions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :flashcard_set, null: false, foreign_key: true

      t.timestamps
    end
  end
end
