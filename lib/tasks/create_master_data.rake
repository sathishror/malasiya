namespace :tap do
	task :it => [:environment, "db:drop", "db:create", "db:migrate", "db:seed"] do
	end
	
	desc "Creating roles"
	task :roles  => :environment do
		roles = ["Super Admin", "Department Admin", "Department User", "Unit Admin"]
	        roles.each do | role |
                   role = Role.new(:name => role)
                   role.save
          end
  end
   
  desc "Creating Super Admin User"
	task :super_admin => :environment do
    super_admin = User.new(:ic_number => "123456-78-1234", :email => 'manivannan.s@openwavecomp.in', :username => "openwave", :password => "password", :first_name => "openwave", :last_name => "superadmin")
    if super_admin.save
      #role_membership = RoleMembership.create(:user_id => super_admin.id, :role_id => 1)
    end
  end

end

		
	     
	   
	   
         		
    
