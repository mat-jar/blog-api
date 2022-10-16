class CreateTeacherTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :teacher_tokens do |t|
      t.string :token
      t.references :teacher, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
    add_index :teacher_tokens, :token, unique: true
  end
end
