class CategoriesDepartments < ActiveRecord::Base
  belongs_to :category
  belongs_to :department
end
