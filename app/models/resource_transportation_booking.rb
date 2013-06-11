class ResourceTransportationBooking < ActiveRecord::Base
  #Upload 
  mount_uploader :attachment, TransportAvatarUploader
  
  #Associations
  #belongs_to :resource
  belongs_to :vehicle
  belongs_to :sub_category
  belongs_to :agency_store

  after_update :mail_to_user_regarding_transport_status_updates

  #Validations

  attr_accessible :status,:agency_store_id,:driver_id,:remarks,:state,:sub_category_id,:purpose,:number_of_passengers,:pick_up_place,:requested_from_date,:requested_to_date,:location,:attachment
  
  validates :remarks,:sub_category_id,:purpose,:number_of_passengers,:pick_up_place,:requested_from_date,:requested_to_date,:location,:state, :presence => true
  validates_numericality_of :number_of_passengers
  validate :validate_end_date_before_start_date
  validate :validate_start_date


  def validate_end_date_before_start_date
    if self.requested_from_date && self.requested_to_date
      errors.add(:Error,"From Date Should be Lesser than To Date") if self.requested_from_date > self.requested_to_date
    end
  end

  def validate_start_date
    if self.requested_from_date
      errors.add(:Error,"From Date should not be lesser than Today") if self.requested_from_date < Date.today
    end    
  end

  def mail_to_user_regarding_transport_status_updates
    user = User.find(self.requester_id)
    UserMailer.send_mail_to_user_for_transport_booking(user,self).deliver
  end
end
