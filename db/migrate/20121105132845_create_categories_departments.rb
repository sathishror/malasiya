class CreateCategoriesDepartments < ActiveRecord::Migration
  def self.up
    create_table :categories_departments do |t|
      t.integer :category_id
      t.integer :department_id
      t.boolean :is_active, :default => true
      t.timestamps
    end
  end

  def self.down
    drop_table :categories_departments
  end
end
