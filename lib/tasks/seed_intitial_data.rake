require 'rubygems'
namespace :create do
  desc 'create roles' 
  task :roles => :environment do
    role = Role.new(:name => 'Super Admin')
    role.save
    role = Role.new(:name => 'Department Admin')
    role.save
    role = Role.new(:name => 'Department User')
    role.save
    role = Role.new(:name => 'Unit Admin')
    role.save
  end
end

namespace :create do
  desc'create super admin user'
  task :super_admin => :environment do
    user = User.create!(:ic_number => "123456-78-1234", :email => 'manivannan.s@openwavecomp.in', :username => "openwave", :password => "password", :first_name => "openwave", :last_name => "superadmin", :role_id => 1)
    user.activate_user
    puts "Created Super Admin User with IC-Number 123456-78-1234 & password as password"
  end
end     

namespace :create do
  desc 'insert department data in db'
  task :department => :environment do
    begin
      file = File.open("public/Department.csv", "r")
      file.readlines.each_with_index do |record, i|
        begin
          Department.create(:name=>record, :is_active=>true, :created_by=>1, :updated_by=>1)
        rescue Exception =>e
          p "Exception ocurred due to #{e.to_s} at #{i}"
        end
      end
    rescue Exception=>e
      p "Exception due to : #{e.to_s}"
    end
  end

  desc 'drop department data in db'
  task :delete => :environment do
    begin
      Department.delete_all
    rescue Exception=>e
      p "Exception due to : #{e.to_s}"
    end
  end
end

namespace :create do
  desc 'insert state data in db'
  task :state => :environment do
    begin
      file = File.open("public/State.csv", "r")
      file.readlines.each_with_index do |record, i|
        begin
          record_split = record.split(",")
          State.create(:name=>record_split[0],:code=>record_split[1], :tel_code=>record_split[2])
        rescue Exception =>e
          p "Exception ocurred due to #{e.to_s} at #{i}"
        end
      end
    rescue Exception=>e
      p "Exception due to : #{e.to_s}"
    end
  end
end
