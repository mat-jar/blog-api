class AddLearnableToLearningSessions < ActiveRecord::Migration[7.0]
  def change
    add_reference :learning_sessions, :learnable, polymorphic: true, index: true
  end
end
