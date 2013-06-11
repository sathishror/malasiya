class Role < ActiveRecord::Base
  has_many :role_memberships
  has_many :users, :through => :role_memberships
  has_many :departments, :through => :role_memberships
end
