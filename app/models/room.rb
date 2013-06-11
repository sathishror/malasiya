class Room < ActiveRecord::Base
   validates :name, :presence => true
   validates :location, :presence => true
   validates :extension_no, :presence => true
end
