class CreateAnswerTimes < ActiveRecord::Migration[7.0]
  def change
    create_table :answer_times do |t|
      t.references :learning_session, null: false, foreign_key: true
      t.references :flashcard, null: false, foreign_key: true
      t.integer :round
      t.integer :time_millisecond

      t.timestamps
    end
  end
end
