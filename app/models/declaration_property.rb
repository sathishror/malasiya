class DeclarationProperty < ActiveRecord::Base
   mount_uploader :property_file, DeclarationPropertyUploader
   mount_uploader :property_file1, DeclarationPropertyUploader
   mount_uploader :property_file2, DeclarationPropertyUploader
   mount_uploader :property_file3, DeclarationPropertyUploader
   mount_uploader :property_file4, DeclarationPropertyUploader
end
