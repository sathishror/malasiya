class ResourceManager < ActiveRecord::Base
  belongs_to :agency
  belongs_to :resource

  scope :active, where(:is_active => true, :deleted => false)
end
