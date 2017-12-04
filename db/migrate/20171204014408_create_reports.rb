class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
          t.string :message_type
          t.integer :transmission_type
          t.string :session_id
          t.string :aircraft_id
          t.string :hex_ident
          t.string :flight_id
          t.string :date_message_generated
          t.string :time_message_generated
          t.string :date_message_logged
          t.string :time_message_logged
          t.string :call_sign
          t.integer :altitude
          t.float :ground_speed
          t.float :track
          t.float :latitude
          t.float :longitude
          t.integer :vertical_rate
          t.string :squawk
          t.string :alert
          t.string :emergency
          t.string :spi
          t.string :is_on_ground
      t.timestamps
    end
  end
end
