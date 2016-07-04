desc "This task is called by the Heroku scheduler add-on"

task :daily_notification => :environment do
  DailyMailer.daily_update
end