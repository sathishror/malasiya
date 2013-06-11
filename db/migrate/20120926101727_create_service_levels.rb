class CreateServiceLevels < ActiveRecord::Migration
  def self.up
    create_table :service_levels do |t|
      t.string :stage
      t.timestamps
    end
    ServiceLevel.create  :stage=>"Kumpulan Pengurusan Tertinggi"
    ServiceLevel.create  :stage=>"Kumpulan Pengurusan dan Professional"
    ServiceLevel.create  :stage=>"Kumpulan Sokongan I"
    ServiceLevel.create  :stage=>"Kumpulan Sokongan II"
  end

  def self.down
    drop_table :service_levels
  end
end
