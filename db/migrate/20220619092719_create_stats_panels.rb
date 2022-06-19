class CreateStatsPanels < ActiveRecord::Migration[7.0]
  def change
    create_table :stats_panels do |t|
      t.text :message

      t.timestamps
    end
  end
end
