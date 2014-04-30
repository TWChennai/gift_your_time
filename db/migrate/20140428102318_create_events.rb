class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.date :date
      t.time :start_time
      t.time :end_time
      t.text :description
      t.integer :user_id

      t.timestamps
    end
  end
end
