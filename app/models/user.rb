class User < ActiveRecord::Base

  #Filters
  before_create :make_activation_code

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,:ic_number, :first_name, :last_name, :username,:city, :state,:zipcode, :department_id, :is_admin, :avatar, :avatar_cache, :remove_avatar, :role_id, :widget_one, :widget_two, :profile_status, :contact_mobile, :gender, :marital_status, :date_of_birth, :hp_number, :address, :child

  #Associations
  has_many :role_memberships
  has_many :roles, :through => :role_memberships
  has_many :departments, :through => :role_memberships
  has_many :units, :through => :role_memberships
  has_many :conversations
  has_many :ict_vpns
  has_many :ict_system_accesses
  has_many :complaint_building_assets
  has_many :complaint_computers
  has_many :resource_ict_equipment_bookings
  has_many :agency

  #helper for carrier wave
  mount_uploader :avatar, ProfileImageUploader

  #Validations
#  validates :ic_number, :zipcode, :city, :state, :presence=>true
  validates_integrity_of :avatar
  validates_processing_of :avatar
  validates_uniqueness_of :username , :if=>Proc.new {|u| !u.username.blank?}
  validates :ic_number, :length => { :is => 12 }, :if=>Proc.new {|u| !u.ic_number.blank?}
  validates_uniqueness_of :ic_number , :if=>Proc.new {|u| !u.ic_number.blank?}
  validates_numericality_of :ic_number, :if=>Proc.new {|u| !u.ic_number.blank?}
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :if=>Proc.new {|u| !u.email.blank?}
  validates_format_of :contact_mobile, :with=>/^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/
  validate :validate_date_of_birth, :if=>Proc.new {|u| u.date_of_birth!=nil }

  def validate_date_of_birth
    errors.add(:base,"Date of Birth Should be less than current date and time") if self.date_of_birth!=nil && self.date_of_birth>=Date.today
  end

  #  validates :avatar,    :file_size => {:maximum => 0.5.megabytes.to_i}, :if=>Proc.new {|u| !u.avatar.blank?}
  #  attr_accessor :agency
  #  validates :agency,  :presence => true, :if=>Proc.new{|u| u.id!=1}
  #Scopes
  scope :active, where(:deleted => false)

  #  define_index do
  #    indexes :username,  :sortable => true
  #    indexes :ic_number,  :sortable => true
  #    indexes [first_name, last_name], :as => :name, :sortable => true
  #    indexes :email
  #  end
  
  def full_name
    return "NA" if first_name.nil? || last_name.nil?
    full_name=first_name+ " "+last_name
    full_name=full_name.titlecase #capitalize
  end 

  def is_super_admin?
    role = Role.find_by_name(DISP_USER_ROLE_SUPER_ADMIN)
    roles=RoleMembership.where(:user_id=>self.id, :role_id=>role.id)
    return roles && roles.first ? true : false
    #    role.role_memberships.where(:default_dept=>true)
    #    role.users.include?(self)
  end

  def is_department_admin?
    role = Role.find_by_name(DISP_USER_ROLE_DEPT_ADMIN)
    roles=RoleMembership.where(:user_id=>self.id, :role_id=>role.id)
    return roles && roles.first ? true : false
    #    return role.users.include?(self)
  end

  def is_department_user?
    role = Role.find_by_name(DISP_USER_ROLE_DEPT_USER)
    roles=RoleMembership.where(:user_id=>self.id, :role_id=>role.id)
    return roles && roles.first ? true : false
    #    return role.users.include?(self)
  end

  def is_unit_admin?
    role = Role.find_by_name(DISP_USER_ROLE_UNIT_ADMIN)
    roles=RoleMembership.where(:user_id=>self.id, :role_id=>role.id)
    return roles && roles.first ? true : false
    #    return role.users.include?(self)
  end

  def is_resource_manager?
    role = Role.find_by_name(DISP_USER_ROLE_RESOURCE_MANAGER)
    roles = RoleMembership.where(:user_id=>self.id, :role_id=>role.id)
    return roles && roles.first ? true : false
    #    return role.users.include?(self)
  end

  def is_datuk_suk?
    role = Role.find_by_name(DISP_USER_ROLE_DATUK_SUK)
    roles = RoleMembership.where(:user_id=>self.id, :role_id=>role.id)
    return roles && roles.first ? true : false
  end

  def is_suk_deputy?
    role = Role.find_by_name(DISP_USER_ROLE_SUK_DEPUTY)
    roles = RoleMembership.where(:user_id=>self.id, :role_id=>role.id)
    return roles && roles.first ? true : false
  end

  def is_human_resource_manager?
    role = Role.find_by_name(DISP_USER_ROLE_HUMAN_RESOURCE)
    roles = RoleMembership.where(:user_id=>self.id, :role_id=>role.id)
    return roles && roles.first ? true : false
  end

  def is_chief_minister?
    role = Role.find_by_name(DISP_USER_ROLE_CHIEF_MINISTER)
    roles = RoleMembership.where(:user_id=>self.id, :role_id=>role.id)
    return roles && roles.first ? true : false
  end


  def activate_user
    self.activated_at = Time.now.utc
    self.activation_code = nil
    self.status = 'Active'  # By default new user will get active on create user page
    self.current_sign_in_at=Time.now
    self.last_sign_in_at=(Time.now-1.days)
    self.sign_in_count=1
    self.save
  end

  # Activates the user in the database.
  def activate
    @activated = true
    self.activated_at = Time.now.utc
    self.activation_code = nil
    self.save
  end
  
  # the existence of an activation code means they have not activated yet
  def account_active?
    if self.is_super_admin?
      activation_code.nil? && user_status_active?
    else
      activation_code.nil? && user_status_active? &&  user_department_active?
    end
  end

  #This method checks if a user is active
  def user_status_active?
    return self.status=="Active" ? true : false
  end

  #This method checks if a department is active
  def user_department_active?
    return self.departments && self.departments.active && !self.departments.active.empty? ? true : false
  end

  #This method overrides default error message for the custom user validation for login
  def inactive_message
    user_department_active? ? (user_status_active? ? super : "Your account has been deactivated!") : "Your department has been deactivated!"
  end

  #Override basic authentication to check if  user is activated or not before login
  def active_for_authentication?
    super && account_active?
  end

  def save_ip(ip)
    existing = self.ips ? self.ips.split(", ") : []
    new = (ip.to_a + existing).uniq.compact[0..9]
    self.update_attribute(:ips, new.join(", ")) unless new == existing
  end

  private

  def update_avatar_attributes
    if avatar.present? && avatar_changed?
      self.content_type = avatar.file.content_type
      self.file_size = avatar.file.size
    end
  end
  
  protected

  def make_activation_code
    self.activation_code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
  end

  #I dont think so this method is needed. Becaz, if we are going to do authentication based on two fields we can use this method. Since we are doing authentication based on IC number only, it is not needed. I checked the sign in and sign up. It's working good. Nirmala, IF u think My suggestion is ok, Please remove it. while you are seeing this msg.
  #def self.find_for_database_authentication(conditions={})
  # self.where("ic_number = ?", conditions[:ic_number]).limit(1).first
  #end
    
end

