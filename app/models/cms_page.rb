class CmsPage < ActiveRecord::Base
#  mount_uploader :cms_page, ContentUploader
  validates :title, :content, :presence => true
end
