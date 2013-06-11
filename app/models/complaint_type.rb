class ComplaintType < ActiveRecord::Base
  belongs_to :building_asset_type
  has_many :system_accesses
end
