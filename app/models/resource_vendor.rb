class ResourceVendor < ActiveRecord::Base
  belongs_to :resource
  belongs_to :vendor
end
