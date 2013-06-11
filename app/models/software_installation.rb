class SoftwareInstallation < ActiveRecord::Base
   mount_uploader :software_attachment, SoftwareAttachmentUploader
end
