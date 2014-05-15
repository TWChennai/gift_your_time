class CreateEventParticipations < ActiveRecord::Migration
  def change
    create_table :event_participations do |t|
      t.integer :event_id
      t.integer :user_id

      t.timestamps
    end
  end
end
