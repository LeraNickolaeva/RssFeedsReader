class DailyMailer < ActionMailer::Base
  default from: "testtask42@gmail.com"

  def daily_update(user)
    @user = user
    @feeds = user.Feed.last(5)

    mail to: user.email, subject: "Daily news"
  end
end