require 'rubygems'
require 'csv'
require 'nokogiri'
require 'mail'
require 'pry'


@filename = "/root/AUTOVALIDATOR/updatedamilist"
p "hello"
Mail.defaults do
 delivery_method :smtp,  {
   :address => 'smtp.gmail.com',
   :port => '587',
   :user_name => 'insights@intellolabs.com',
   :password => 'intellolabs@123',
   :authentication => 'plain',
   :enable_starttls_auto => true}
 end

 @mail = Mail.new do
   from 'abc@i.com'
   #to 'abc@i.com'
   to 'abc@i.com'
   cc 'shrikant.verma@iu.com,abc@i.com'

   subject 'AV ami update status report'
   body 'Hello Sir,
   Av ami is updated in autoscaling group'

 end

 @mail.add_file("#{@filename}")
 @mail.deliver!
p "Mail sent successfully."
