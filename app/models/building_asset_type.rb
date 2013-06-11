class BuildingAssetType < ActiveRecord::Base
  has_many :complaint_type
  belongs_to :complaint_building_asset
end
