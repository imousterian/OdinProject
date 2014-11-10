class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
        t.integer :attendee_id
        t.integer :attended_event_id
        t.timestamps
    end
  end
end
