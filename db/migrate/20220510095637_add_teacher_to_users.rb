class AddTeacherToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :teacher, foreign_key: { to_table: :users }
end
end
