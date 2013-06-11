class AddAllDeptsAdminMessageInMessages < ActiveRecord::Migration
  def self.up
    add_column :messages,:sent_to_all_dept_admins,:boolean,:default => false
  end

  def self.down
    remove_column :messages,:sent_to_all_dept_admins
  end
end
