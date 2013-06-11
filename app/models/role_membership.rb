class RoleMembership < ActiveRecord::Base
  #Associations comes here
  belongs_to :role
  belongs_to :user
  belongs_to :department
  belongs_to :unit
  validates_associated :user,
    :if => Proc.new { |a| a.user.present? }
  validates :role_id, :presence=>true
  validates :department_id, :presence=>true, :if=>Proc.new{|u| u.role_id!=1}
end
