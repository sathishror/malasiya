class UserService < ActiveRecord::Base

  attr_accessible :service_level_id,:classification_id,:grade_id,:service_standard_id,:appointment_id,:salary_scale1,:salary_scale2,:email,:position,:office_address,:office_number,:office_fax,:postal_code,:city,:state,:recent_salary,:user_id,:first_appointment_to_public_service,:first_appointment_to_present_position,:promotion_to_present_grade,:confirmation_date

  validates :service_level_id,:classification_id,:grade_id,:service_standard_id,:appointment_id,:salary_scale1,:salary_scale2,:office_address,:office_number,:office_fax,:postal_code,:city,:state,:recent_salary,:first_appointment_to_public_service,:first_appointment_to_present_position, :presence => true

  validates_format_of :email, :with => /^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/i
  
  #validate :first_appointment_to_public_service_should_be_lesser_than_first_appointment_to_the_present_post,:first_appointment_to_present_post_should_be_lesser_than_promotion_to_present_grade,:promotion_to_present_grade_should_be_lesser_than_confirmation_date

#  def first_appointment_to_public_service_should_be_lesser_than_first_appointment_to_the_present_post
#    if self.first_appointment_to_public_service && self.first_appointment_to_present_position
#      errors.add(:Error,"Date of First Appointment of Public Service Should be Lesser than Date of First Appointment of the Present Post") if self.first_appointment_to_public_service > self.first_appointment_to_present_position
#    end
#  end
#
#  def first_appointment_to_present_post_should_be_lesser_than_promotion_to_present_grade
#    if self.first_appointment_to_present_position && self.promotion_to_present_grade
#      errors.add(:Error,"Date of First Appointment of the Present Post Should be Lesser than Date of Promotion to Present Grade") if self.first_appointment_to_present_position > self.promotion_to_present_grade
#    end
#  end
#
#  def promotion_to_present_grade_should_be_lesser_than_confirmation_date
#    if self.promotion_to_present_grade && self.confirmation_date
#      errors.add(:Error,"Promotion to Present Grade Should be Lesser than Confirmation Date") if self.promotion_to_present_grade > self.confirmation_date
#    end
#  end
#
end
