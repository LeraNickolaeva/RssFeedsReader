class SocialProvider < ActiveRecord::Base

  #Relations
  belongs_to :user

  def self.find_for_oauth(auth, provider_type)
    unless social_provider = self.find_by(pid: auth[:uid].to_s, provider_type: provider_type)
      user = User.find_by_email(auth[:info][:email])
      social_provider = user.social_providers.where(provider_type: provider_type).first if user.present?
      social_provider ||= SocialProvider.new
    end
    social_provider.update_from_oauth(auth, provider_type)
    social_provider
  end

  def update_from_oauth(auth, provider_type)
    self.email= auth[:info][:email]
    self.pid= auth[:uid]
    self.provider_type= provider_type
    credentials = auth[:credentials]
    case provider_type
      when :twitter
        self.token = credentials[:token]
        self.secret = credentials[:secret]
        self.url = auth[:info][:urls][:Twitter]
  end
  end
  end