require File.expand_path("../../config/environment", __FILE__) 
include Stalker

error do |e,job,args|
  puts "something bad happened"
  pp e
  puts e.backtrace.join("\n")
  pp job
  pp args
  puts "happy debugging"
end

job "#{SPREFIX}.send.welcome" do |args| 
  user = User.find(args["id"])  
  password = args["password"]
  puts "sending welcome mail to #{user.email}"
  WelcomeMailer.for_user(user, password).deliver!
end
 
Stalker.work nil
