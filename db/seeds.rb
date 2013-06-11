# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

puts "All right! I have started seeding, now please be patient."

puts "Creating Vendor"
vendors = [
  ['Vendor_one',  'PERANAKAN', '012-112-1111', true],
  [ 'Vendor_two',  'ST.PAUL HILL', '012-112-1112',  true],
  [ 'Vendor_three',  'PULAU UPEH',  '012-112-1113', true],
  [ 'Vendor_four','HARI MERDEKA',  '012-112-1114',  true]
]
vendors.each do |vendor|
  Vendor.create!(:name => vendor[0],:address=>vendor[1],:contact_no=>vendor[2], :is_active =>vendor[3])
end

puts "Creating Roles"
roles = ["Super Admin", "Department Admin", "Department User", "Unit Admin", "Resource Manager", "Datuk SUK", "SUK Deputy", "Human Resource", "Y.A.B Chief Minister"]
roles.each do | role |
  Role.create!(:name => role)
end

puts "Creating Agencies"
agencies = [
  ['Agency_one', 'Adress Agency One', '012-345-1111', true],
  ['Agency_two', 'Adress Agency Two', '012-345-2222', true],
  ['Agency_three', 'Adress Agency Three', '012-345-3333', true],
  ['Prakash_Agency_One', 'Test Address1', '012-345-1110', true],
  ['Prakash_Agency_Two', 'Test Address2', '012-345-2202', true],
  ['Prakash_Agency_Three', 'Test Address3', '012-345-3033', true],
  ['Prakash_Agency_Four', 'Test Address4', '012-345-0111', true],
  ['Prakash_Agency_Five', 'Test Address5', '012-345-2022', true]
]
agencies.each do | agency |
  Agency.create!(:name => agency[0], :address=>agency[1], :telephone_number=>agency[2], :is_active => agency[3])
end

puts "Creating Departments"

departments = [
  ['Jabatan Ketua Menteri Melaka', 'Dept One','012-345-4444',1,true],
  ['Jabatan Mufti Negeri Melaka', 'Dept Two','012-345-5555',1,true],
  ['Jabatan Agama Islam Melaka' 'Dept Three','012-345-6666',2,true],
  ['Jabatan Kerja Raya Melaka','Dept Four','012-345-7777',2,true],
  ['Jabatan Pertanian Negeri Melaka','Dept Five','012-345-8888',3,true],
  ['Jabatan Kebajikan Masyarakat','Dept Six','012-345-9999',3,true],
  ['Test Department1 of Prakash_Agency_One','Dept One','012-345-4446',4,true],
  ['Test Department2 of Prakash_Agency_One','Dept Two','012-345-5557',4,true],
  ['Test Department3 of Prakash_Agency_One','Dept Three','012-345-6668',4,true],
  ['Test Department1 of Prakash_Agency_Two','Dept Four','012-345-7779',5,true],
  ['Test Department2 of Prakash_Agency_Two','Dept Five','012-345-8882',5,true],
  ['Test Department3 of Prakash_Agency_Two','Dept Six','012-345-9995',5,true],
  ['Test Department1 of Prakash_Agency_Three','Dept One','012-345-4446',6,true],
  ['Test Department2 of Prakash_Agency_Three','Dept Two','012-345-5558',6,true],
  ['Test Department3 of Prakash_Agency_Three','Dept Three','012-345-6665',6,true],
  ['Test Department1 of Prakash_Agency_Four','Dept Four','012-345-7775',7,true],
  ['Test Department2 of Prakash_Agency_Four','Dept Five','012-345-8885',7,true]
]

departments.each do |department|
  Department.create(:name => department[0] ,:address => department[1], :telephone_number => department[2], :agency_id => department[3], :is_active => department[4])
end


users=[

  ["123456781234", "9801498404", 'manivannan.s@openwavecomp.in', "password", "openwave",'Mani', "superadmin" ],
  ["123456780001", "9801498404", 'sathisht@openwavecomp.in', "password", "James", "Franklin", 'James',["1","5"]],
  ["123456780002", "9801498404", 'sathish@openwavecomp.in', "password", "Sheik", "Sultan", 'Sultan',["3","5"]],

  ["123456700001", "9801498404", 'datuksuk@openwavecomp.in', "password", "Datuk", "SUK", 'Datuk SUK',["1","6"]],
  ["123456700011", "9801498404", 'sukdeputy@openwavecomp.in', "password", "SUK", "Sultan", 'SUK Deputy',["1","7"]],
  ["123456700111", "9801498404", 'hrdept@openwavecomp.in', "password", "HR", "HR", 'Human Resource',["1","8"]],
  ["123456123456", "9801498404", 'yab@openwavecomp.in', "password", "Y.A.B", "Minister", 'Chief Minister',["1","9"]],

  ["123456781111", "9801498404", 'sathish.t@openwavecomp.in', "password", "Dept1Admin", "JKMM", 'Sathish',["1","2"]],
  ["123456782222", "9801498404", 'sheikdawood.a@openwavecomp.in', "password", "Dept2Admin", "JKMM", 'Sheik',["2","2"]],
  ["123456783333", "9801498404", 'mathewvivek.a@openwavecomp.in', "password", "Dept3Admin", "JKMM", 'Mathew',["3","2"]],
  ["123456784444", "9801498404", 'nirmala.a.b@openwavecomp.in', "password", "Dept4Admin", "JKMM", 'Nirmala',["4","2"]],
  ["123456785555", "9801498404", 'sasitharan.t@openwavecomp.in', "password", "Dept5Admin", "JKMM", 'Sasitharan',["5","2"]],
  ["123456786666", "9801498404", 'prakashkumar.m@openwavecomp.in', "password", "Dept6Admin", "JKMM", 'Prakash',["6","2"]],

  ["123456781110", "9801498404", 'testopen06@gmail.com.in', "password", "Dept1UserFirst", "JKMM", 'TestOpen06',["1","3"]],
  ["123456781120", "9801498404", 'abuthahir.a.b@openwavecomp.in', "password", "Dept1UserSecond", "JKMM", 'Abuthahir',["1","3"]],
  ["123456781130", "9801498404", 'testopen07@gmail.com', "password", "Dept1UserThird", "JKMM", 'TestOpen07',["1","3"]],

  ["123456782210", "9801498404", 'anusudha.r@openwavecomp.in', "password", "Dept2UserFirst", "JMNM", 'Anu',["2","3"]],
  ["123456782220", "9801498404", 'latha.k@openwavecomp.in', "password", "Dept2UserSecond", "JMNM", 'Latha',["2","3"]],
  ["123456782230", "9801498404", 'sakthivel.m@openwavecomp.in', "password", "Dept2UserThird", "JMNM", 'Sakthi',["2","3"]],

  ["123456783310", "9801498404", 'gopinath.m@openwavecomp.in', "password", "Dept3UserFirst", "JAIM", 'Gopinath',["3","3"]],
  ["123456783320", "9801498404", 'testopen01@gmail.com', "password", "Dept3UserSecond", "JAIM", 'TestOpen01',["3","3"]],
  ["123456783330", "9801498404", 'testopen02@gmail.com', "password", "Dept3UserThird", "JAIM", 'TestOpen02',["3","3"]],

  ["123456784410", "9801498404", 'testopen03@gmail.com', "password", "Dept4UserFirst", "JKRM", 'TestOpen03',["4","3"]],
  ["123456784420", "9801498404", 'testopen04@gmail.com', "password", "Dept4UserSecond", "JKRM", 'TestOpen04',["4","3"]],
  ["123456784430", "9801498404", 'testopen05@gmail.com', "password", "Dept4UserThird", "JKRM", 'TestOpen05',["4","3"]],

  ["123456785510", "9801498404", 'testopen08@gmail.com', "password", "Dept5Userfirst", "JPNM", 'TestOpen08',["5","3"]],
  ["123456785520", "9801498404", 'testopen09@gmail.com', "password", "Dept5UserSecond", "JPNM", 'TestOpen09',["5","3"]],
  ["123456785530", "9801498404", 'john.poul01@gmail.com', "password", "Dept5UserThird", "JPNM", 'JohnPoul01',["5","3"]],

  ["123456786610", "9801498404", 'john.poul02@gmail.com', "password", "Dept6Userfirst", "JKM", 'JohnPoul02',["6","3"]],
  ["123456786620", "9801498404", 'john.poul03@gmail.com', "password", "Dept6UserSecond", "JKM", 'JohnPoul03',["6","3"]],
  ["123456786630", "9801498404", 'john.poul04@gmail.com', "password", "Dept6UserThird", "JKM", 'JohnPoul04',["6","3"]],

  ["100000000000", "9801498404", 'prakashtest01@gmail.com', "123456789", "Prakash DA1", "Muthu DA1", 'Prakash DA One',["7","2"]],
  ["200000000000", "9801498404", 'prakashtest02@gmail.com', "123456789", "Prakash DA2", "Muthu DA2", 'Prakash DA Two',["8","2"]],
  ["300000000000", "9801498404", 'prakashtest03@gmail.com', "123456789", "Prakash DA3", "Muthu DA3", 'Prakash DA Three',["10","2"]],

  ["100000001111", "9801498404", 'prakashtest04@gmail.com', "123456789", "Prakash DU1", "Muthu DU1", 'Prakash DU One',["7","3"]],
  ["100000002222", "9801498404", 'prakashtest05@gmail.com', "123456789", "Prakash DU2", "Muthu DU2", 'Prakash DU Two',["7","3"]],
  ["100000003333", "9801498404", 'prakashtest10@gmail.com', "123456789", "Prakash DU3", "Muthu DU3", 'Prakash DU Three',["7","3"]],
  ["200000001111", "9801498404", 'prakashtest06@gmail.com', "123456789", "Prakash DU3", "Muthu DU4", 'Prakash DU Fourth',["8","3"]],
  ["300000001111", "9801498404", 'prakashtest07@gmail.com', "123456789", "Prakash DU4", "Muthu DU5", 'Prakash DU Fifth',["10","3"]],

  ["100000000011", "9801498404", 'prakashtest08@gmail.com', "123456789", "Prakash RM1", "Muthu RM1", 'Prakash RM One',["7","5"]],
  ["200000000011", "9801498404", 'prakashtest09@gmail.com', "123456789", "Prakash RM2", "Muthu RM2", 'Prakash RM Two',["10","5"]]


]
users.each do |user|
  new_user = User.create(:ic_number => user[0], :contact_mobile => user[1], :email => user[2],:password => user[3],:first_name =>user[4], :last_name => user[5],:username=>user[6], :status => 'A', :state => 7, :sign_in_count => 1)
  new_user.activate_user
  if new_user.save!
    RoleMembership.create(:user_id => new_user.id, :role_id => 1, :status => 'A') if new_user.id == 1
    RoleMembership.create(:user_id => new_user.id, :department_id => user[7][0], :role_id => user[7][1], :status => 'A', :default_dept=>true) if new_user.id!=1
  end
end


#
#puts "Creating Agencies"
#begin
#  file = File.open("public/Agency.csv", "r")
#  file.readlines.each_with_index do |record, i|
#    begin
#      record_split = record.split(",")
#      Agency.create(:name=>record_split[0],:address=>record_split[1], :telephone_number=>record_split[2] ,:is_active=>true)
#    rescue Exception =>e
#      p "Exception ocurred due to #{e.to_s} at #{i}"
#    end
#  end
#rescue Exception=>e
#  p "Exception due to : #{e.to_s}"
#end
#
#puts "Creating Departments"
#begin
#  file = File.open("public/Department.csv", "r")
#  file.readlines.each_with_index do |record, i|
#    begin
#      n=18
#      agency_id=(1..n).to_a.sample
#      record_split = record.split(",")
#      Department.create!(:agency_id => agency_id, :name=>record_split[0].titleize,:address=>record_split[1],:telephone_number=>record_split[2], :is_active=>true, :created_by=>1, :updated_by=>1)
#    rescue Exception =>e
#      p "Exception ocurred due to #{e.to_s} at #{i}"
#    end
#  end
#rescue Exception=>e
#  p "Exception due to : #{e.to_s}"
#end
puts "Creating Drivers"
begin
  file = File.open("public/Driver.csv", "r")
  file.readlines.each_with_index do |record, i|
    begin
      record_split = record.split(",")
      Driver.create!(:registration_id=>record_split[0],:name=>record_split[1], :telephone_number=>record_split[2])
    rescue Exception =>e
      p "Exception ocurred due to #{e.to_s} at #{i}"
    end
  end
rescue Exception=>e
  p "Exception due to : #{e.to_s}"
end

puts "Creating States"
begin
  file = File.open("public/State.csv", "r")
  file.readlines.each_with_index do |record, i|
    begin
      record_split = record.split(",")
      State.create!(:name=>record_split[0],:code=>record_split[1], :tel_code=>record_split[2])
    rescue Exception =>e
      p "Exception ocurred due to #{e.to_s} at #{i}"
    end
  end
rescue Exception=>e
  p "Exception due to : #{e.to_s}"
end

puts "Creating VehicleTypes"
begin
  file = File.open("public/VehicleType.csv", "r")
  file.readlines.each_with_index do |record, i|
    begin
      record_split = record.split(",")
      VehicleType.create!(:name=>record_split[0])
    rescue Exception =>e
      p "Exception ocurred due to #{e.to_s} at #{i}"
    end
  end
rescue Exception=>e
  p "Exception due to : #{e.to_s}"
end

puts "Creating sample resources for a resources category"
categories=['Stationery Item','Computer Hardware and Accessories','Computer Software', 'Communications','Office Furniture and Equipment','Room','Transportation', 'ICT Equipment']
categories.each do |category|
  Category.create(:name=>category)
end

puts "Creating Sample sub resource category for a stationery item resource category"
resource_sub_categories1 = SubCategory.create(:category_id => 1, :name => 'Pencil')
resource_sub_categories2 = SubCategory.create(:category_id => 1, :name => 'Paper Weight')
resource_sub_categories3 = SubCategory.create(:category_id => 1, :name => 'Register Book')
resource_sub_categories4 = SubCategory.create(:category_id => 1, :name => 'Stapler (small & big)')
resource_sub_categories5 = SubCategory.create(:category_id => 1, :name => 'Stapler Pin (small & big)')
resource_sub_categories6 = SubCategory.create(:category_id => 1, :name => 'Stamp Pad')
resource_sub_categories7 = SubCategory.create(:category_id => 1, :name => 'Stamp Pad Ink')
resource_sub_categories8 = SubCategory.create(:category_id => 1, :name => 'Pen')
resource_sub_categories9 = SubCategory.create(:category_id => 1, :name => 'File Folder')
resource_sub_categories10 = SubCategory.create(:category_id => 1, :name => 'Gum')
resource_sub_categories11 = SubCategory.create(:category_id => 1, :name => 'Permanent Marker')
resource_sub_categories12 = SubCategory.create(:category_id => 1, :name => 'Hand Book')
resource_sub_categories13 = SubCategory.create(:category_id => 1, :name => 'Envelope(small)')
resource_sub_categories14 = SubCategory.create(:category_id => 1, :name => 'Envelope(large)')
resource_sub_categories15 = SubCategory.create(:category_id => 1, :name => 'Sealing Wax')
resource_sub_categories16 = SubCategory.create(:category_id => 1, :name => 'Brown Cover(A4 size)')
resource_sub_categories17 = SubCategory.create(:category_id => 1, :name => 'White Paper(A4 size)')
resource_sub_categories18 = SubCategory.create(:category_id => 1, :name => 'Double Punch')
resource_sub_categories19 = SubCategory.create(:category_id => 1, :name => 'White Board and Duster')
resource_sub_categories20 = SubCategory.create(:category_id => 1, :name => 'Calculator')
resource_sub_categories21 = SubCategory.create(:category_id => 1, :name => 'Trace Paper')
resource_sub_categories22 = SubCategory.create(:category_id => 1, :name => 'Cash Book')


puts "Creating Sample sub resource category for a computer hardware and accessories "
resource_sub_categories1 = SubCategory.create(:category_id => 2, :name => 'Desktop computer and monitor')
resource_sub_categories2 = SubCategory.create(:category_id => 2, :name => 'Keyboard and Mouse')
resource_sub_categories3 = SubCategory.create(:category_id => 2, :name => 'Printer')
resource_sub_categories4 = SubCategory.create(:category_id => 2, :name => 'Modem')
resource_sub_categories5 = SubCategory.create(:category_id => 2, :name => 'Notebook Computer')
resource_sub_categories6 = SubCategory.create(:category_id => 2, :name => 'CD Writer')
resource_sub_categories7 = SubCategory.create(:category_id => 2, :name => 'PowerPoint Projector')
resource_sub_categories8 = SubCategory.create(:category_id => 2, :name => 'Digital Camera')
resource_sub_categories9 = SubCategory.create(:category_id => 2, :name => 'Handheld Organizer')
resource_sub_categories10 = SubCategory.create(:category_id => 2, :name => 'Surge Protector')
resource_sub_categories11 = SubCategory.create(:category_id => 2, :name => 'Computer Locks')
resource_sub_categories12 = SubCategory.create(:category_id => 2, :name => 'Scanner')
resource_sub_categories13 = SubCategory.create(:category_id => 2, :name => 'Laptop')

puts "Creating Sample sub resource category for a computer software"
resource_sub_categories1 = SubCategory.create(:category_id => 3, :name => 'Word Processing Software')
resource_sub_categories2 = SubCategory.create(:category_id => 3, :name => 'Virus protection Software')
resource_sub_categories3 = SubCategory.create(:category_id => 3, :name => 'Accounting Software')
resource_sub_categories4 = SubCategory.create(:category_id => 3, :name => 'Desktop Publishing Software')
resource_sub_categories5 = SubCategory.create(:category_id => 3, :name => 'Contact Management Software')
resource_sub_categories6 = SubCategory.create(:category_id => 3, :name => 'Website Building and Maintenance Software')
resource_sub_categories7 = SubCategory.create(:category_id => 3, :name => 'Payment Processing Software')
resource_sub_categories8 = SubCategory.create(:category_id => 3, :name => 'E-commerce Software')
resource_sub_categories9 = SubCategory.create(:category_id => 3, :name => 'Inventory Management Software')

puts "Creating Sample sub resource category for a Communications"
resource_sub_categories1 = SubCategory.create(:category_id => 4, :name => 'Telephone Line')
resource_sub_categories2 = SubCategory.create(:category_id => 4, :name => 'Internet Connection')
resource_sub_categories3 = SubCategory.create(:category_id => 4, :name => 'Toll-free Line')
resource_sub_categories4 = SubCategory.create(:category_id => 4, :name => 'Desk Telephone')
resource_sub_categories5 = SubCategory.create(:category_id => 4, :name => 'Fax Machine')
resource_sub_categories6 = SubCategory.create(:category_id => 4, :name => 'Cordless Telephone')
resource_sub_categories7 = SubCategory.create(:category_id => 4, :name => 'Answering Machine/Service')
resource_sub_categories8 = SubCategory.create(:category_id => 4, :name => 'Cordless Headset')
resource_sub_categories9 = SubCategory.create(:category_id => 4, :name => 'Speakerphone')
resource_sub_categories10 = SubCategory.create(:category_id => 4, :name => 'Pager')
resource_sub_categories11 = SubCategory.create(:category_id => 4, :name => 'Tape Recorder')
resource_sub_categories12 = SubCategory.create(:category_id => 4, :name => 'Cellular Telephone with Internet Features')

#puts "Creating Sample sub resource category for a first aid kit"
#resource_sub_categories1 = SubCategory.create(:category_id => 4, :name => 'band-aid')
#resource_sub_categories2 = SubCategory.create(:category_id => 4, :name => 'antibiotic ointment')
#resource_sub_categories3 = SubCategory.create(:category_id => 4, :name => 'tablets')
#resource_sub_categories4 = SubCategory.create(:category_id => 4, :name => 'dettol')
#resource_sub_categories5 = SubCategory.create(:category_id => 4, :name => 'vicks')
#resource_sub_categories6 = SubCategory.create(:category_id => 4, :name => 'antiseptic wipes')
#resource_sub_categories7 = SubCategory.create(:category_id => 4, :name => 'thermometer')

puts "Creating Sample sub resource category for a furnitures resource category"
resource_sub_categories1 = SubCategory.create(:category_id => 5, :name => 'Desk')
resource_sub_categories2 = SubCategory.create(:category_id => 5, :name => 'Comfortable Chair')
resource_sub_categories3 = SubCategory.create(:category_id => 5, :name => 'File Cabinets')
resource_sub_categories4 = SubCategory.create(:category_id => 5, :name => 'Overhead and Work Lighting')
resource_sub_categories5 = SubCategory.create(:category_id => 5, :name => 'Client Seating')
resource_sub_categories6 = SubCategory.create(:category_id => 5, :name => 'Fireproof Safe')
resource_sub_categories7 = SubCategory.create(:category_id => 5, :name => 'Desktop and Pocket Calculators')
resource_sub_categories8 = SubCategory.create(:category_id => 5, :name => 'Bookcases')
resource_sub_categories9 = SubCategory.create(:category_id => 5, :name => 'Postage Meter')
resource_sub_categories10 = SubCategory.create(:category_id => 5, :name => 'Worktable(s)')
resource_sub_categories11 = SubCategory.create(:category_id => 5, :name => 'Office Decorations')
resource_sub_categories12 = SubCategory.create(:category_id => 5, :name => 'Wall Whiteboard and Markers')
resource_sub_categories13 = SubCategory.create(:category_id => 5, :name => 'Photocopier')
resource_sub_categories14 = SubCategory.create(:category_id => 5, :name => 'Wastebasket')
resource_sub_categories15 = SubCategory.create(:category_id => 5, :name => 'Recycling Bin')
resource_sub_categories16 = SubCategory.create(:category_id => 5, :name => 'Alarm System')
resource_sub_categories17 = SubCategory.create(:category_id => 5, :name => 'Fire Extinguisher')
resource_sub_categories18 = SubCategory.create(:category_id => 5, :name => 'First-aid Kit')

puts "Creating Sample sub resource category for a Room category"
resource_sub_categories1 = SubCategory.create(:category_id => 6, :name => "Conference room")
resource_sub_categories2 = SubCategory.create(:category_id => 6, :name => "Prayer room")
resource_sub_categories2 = SubCategory.create(:category_id => 6, :name => "Dining room")
resource_sub_categories2 = SubCategory.create(:category_id => 6, :name => "Party hall")

puts "Creating Sample sub resource category for a transportation category"
resource_sub_categories1 = SubCategory.create(:category_id => 7, :name => "Kerata", :is_available => false)
resource_sub_categories2 = SubCategory.create(:category_id => 7, :name => "Van",  :is_available => false)
resource_sub_categories2 = SubCategory.create(:category_id => 7, :name => "MPV",  :is_available => false)
resource_sub_categories2 = SubCategory.create(:category_id => 7, :name => "4WD", :is_available => false)
resource_sub_categories2 = SubCategory.create(:category_id => 7, :name => "Bas", :is_available => false)
resource_sub_categories2 = SubCategory.create(:category_id => 7, :name => "Lori", :is_available => false)

p "Creating Sample sub category data for ICT Equipment category"
begin
  file = File.open("public/equipment_category.csv", "r")
  file.readlines.each_with_index do |record, i|
    begin
      SubCategory.create(:category_id => 8 ,:name=>record)
    rescue Exception =>e
      p "Exception ocurred due to #{e.to_s} at #{i}"
    end
  end
rescue Exception=>e
  p "Exception due to : #{e.to_s}"
end
puts "Creating Vehicles"
begin
  file = File.open("public/Vehicle.csv", "r")
  file.readlines.each_with_index do |record, i|
    begin
      record_split = record.split(",")
      Vehicle.create(:registration_id=>record_split[0],:registration_number=>record_split[1],:vehicle_type_id=>record_split[2],:driver_id=>i+1,:model_name=>record_split[3],:registration_date=>record_split[4])
    rescue Exception =>e
      p "Exception ocurred due to #{e.to_s} at #{i}"
    end
  end
rescue Exception=>e
  p "Exception due to : #{e.to_s}"
end


p "Creating Equipment Category for Resource ICT Equipment"

begin
  file = File.open("public/equipment_category.csv", "r")
  file.readlines.each_with_index do |record, i|
    begin
      EquipmentCategory.create(:name=>record ,:is_active=>true)
    rescue Exception =>e
      p "Exception ocurred due to #{e.to_s} at #{i}"
    end
  end
rescue Exception=>e
  p "Exception due to : #{e.to_s}"
end

p "Creating Requisition Types"

begin
  file = File.open("public/Requisition_Types.csv", "r")
  file.readlines.each_with_index do |record, i|
    begin
      RequisitionType.create(:name=>record,:is_active=>true)
    rescue Exception =>e
      p "Exception ocurred due to #{e.to_s} at #{i}"
    end
  end
rescue Exception=>e
  p "Exception due to : #{e.to_s}"
end

p "Creating Facility Ict Agencies"

begin
  file = File.open("public/Facility_Ict_Agencies.csv", "r")
  file.readlines.each_with_index do |record, i|
    begin
      FacilityIctAgency.create(:name=>record,:is_active=>true)
    rescue Exception =>e
      p "Exception ocurred due to #{e.to_s} at #{i}"
    end
  end
rescue Exception=>e
  p "Exception due to : #{e.to_s}"
end

p "Creating Facility Ict Softwares"

begin
  file = File.open("public/Facility_Ict_Softwares.csv", "r")
  file.readlines.each_with_index do |record, i|
    begin
      FacilityIctSoftware.create(:name=>record,:is_active=>true)
    rescue Exception =>e
      p "Exception ocurred due to #{e.to_s} at #{i}"
    end
  end
rescue Exception=>e
  p "Exception due to : #{e.to_s}"
end

p "Creating Facility Ict Wirings"

begin
  file = File.open("public/Facility_Ict_Wirings.csv", "r")
  file.readlines.each_with_index do |record, i|
    begin
      FacilityIctWiring.create(:name=>record,:is_active=>true)
    rescue Exception =>e
      p "Exception ocurred due to #{e.to_s} at #{i}"
    end
  end
rescue Exception=>e
  p "Exception due to : #{e.to_s}"
end

p "Creating Facility Ict Services"

begin
  file = File.open("public/Facility_Ict_Services.csv", "r")
  file.readlines.each_with_index do |record, i|
    begin
      record_split = record.split(",")
      FacilityIctService.create(:name=>record_split[0],:port=>record_split[1],:is_active=>true)
    rescue Exception =>e
      p "Exception ocurred due to #{e.to_s} at #{i}"
    end
  end
rescue Exception=>e
  p "Exception due to : #{e.to_s}"
end

p "Creating Facility Ict Hardwares"

begin
  file = File.open("public/Facility_Ict_Hardwares.csv", "r")
  file.readlines.each_with_index do |record, i|
    begin
      FacilityIctHardware.create(:name=>record,:is_active=>true)
    rescue Exception =>e
      p "Exception ocurred due to #{e.to_s} at #{i}"
    end
  end
rescue Exception=>e
  p "Exception due to : #{e.to_s}"
end

p "Creating Facility Ict Servers"

FacilityIctServer.create(:name=>'Tun Razak 1',:ip=>'172.10.10.172')
FacilityIctServer.create(:name=>'Tun Razak 2',:ip=>'172.10.10.173')

p "Creating System Accesses"

begin
  file = File.open("public/System_Access.csv", "r")
  file.readlines.each_with_index do |record, i|
    begin
      record_split = record.split(",")
      SystemAccess.create(:name=>record_split[0], :is_active=>true, :complaint_type_id=>record_split[1])
    rescue Exception =>e
      p "Exception ocurred due to #{e.to_s} at #{i}"
    end
  end
rescue Exception=>e
  p "Exception due to : #{e.to_s}"
end

p "Creating Facility ICT"

begin
  file = File.open("public/facility_ict.csv", "r")
  file.readlines.each_with_index do |record, i|
    begin
      FacilityIct.create(:name=>record)
    rescue Exception =>e
      p "Exception ocurred due to #{e.to_s} at #{i}"
    end
  end
rescue Exception=>e
  p "Exception due to : #{e.to_s}"
end

puts "Creating Damage Types"
damage_type1 = DamageType.create(:name => 'Building', :parent_type_id => 0, :building_asset_type_id => 1)
damage_type2 = DamageType.create(:name => 'Asset', :parent_type_id => 0, :building_asset_type_id => 34)
damage_type3 = DamageType.create(:name => 'Cleanliness', :parent_type_id => 0, :building_asset_type_id => 40)
damage_type4 = DamageType.create(:name => 'Mechanical', :parent_type_id => 1, :building_asset_type_id => 2)
damage_type5 = DamageType.create(:name => 'Electrical', :parent_type_id => 1, :building_asset_type_id => 3)
damage_type6 = DamageType.create(:name => 'Civil', :parent_type_id => 1, :building_asset_type_id => 35)


p "Creating Building Asset Types"

begin
  file = File.open("public/Building_Asset_Type.csv", "r")
  file.readlines.each_with_index do |record, i|
    begin
      record_split = record.split(",")
      BuildingAssetType.create(:name=>record_split[0], :parent_type_id=>record_split[1])
    rescue Exception =>e
      p "Exception ocurred due to #{e.to_s} at #{i}"
    end
  end
rescue Exception=>e
  p "Exception due to : #{e.to_s}"
end


p "Creating System Model Types"

begin
  file = File.open("public/System_Model_Types.csv", "r")
  file.readlines.each_with_index do |record, i|
    begin
      record_split = record.split(",")
      SystemModelType.create(:name=>record_split[0], :system_access_id=>record_split[1])
    rescue Exception =>e
      p "Exception ocurred due to #{e.to_s} at #{i}"
    end
  end
rescue Exception=>e
  p "Exception due to : #{e.to_s}"
end


p "Creating Complaint Types"

begin
  file = File.open("public/Complaint_Types.csv", "r")
  file.readlines.each_with_index do |record, i|
    begin
      record_split = record.split(",")
      ComplaintType.create(:name=>record_split[0])
    rescue Exception =>e
      p "Exception ocurred due to #{e.to_s} at #{i}"
    end
  end
rescue Exception=>e
  p "Exception due to : #{e.to_s}"
end

p "Creating Vehicle Models"

begin
  file = File.open("public/VehicleModel.csv", "r")
  file.readlines.each_with_index do |record, i|
    begin
      record_split = record.split(",")
      VehicleModelType.create(:name=>record_split[0],:sub_category_id=>record_split[1])
    rescue Exception =>e
      p "Exception ocurred due to #{e.to_s} at #{i}"
    end
  end
rescue Exception=>e
  p "Exception due to : #{e.to_s}"
end

puts "Whoa, im done! Now you can run the server and see the application"
