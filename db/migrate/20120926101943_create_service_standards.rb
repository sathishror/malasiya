class CreateServiceStandards < ActiveRecord::Migration
  def self.up
    create_table :service_standards do |t|
      t.string :name
      t.timestamps
    end
    ServiceStandard.create :name=>"Dalam Tempoh Percubaan"
    ServiceStandard.create :name=>"Tetap"
    ServiceStandard.create :name=>"Kontrak"
    ServiceStandard.create :name=>"Sambilan"
    ServiceStandard.create :name=>"Pinjaman"
    ServiceStandard.create :name=>"Sementara"
  end

  def self.down
    drop_table :service_standards
  end
end
