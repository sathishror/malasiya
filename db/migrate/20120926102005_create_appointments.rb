class CreateAppointments < ActiveRecord::Migration
  def self.up
    create_table :appointments do |t|
      t.string :name
      t.timestamps
    end
    Appointment.create :name=>"Lantikan Terus"
    Appointment.create :name=>"Kenaikan Pangkat Secara Lantikan (KPSL)"
  end

  def self.down
    drop_table :appointments
  end
end
