class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable, :confirmable
  devise :omniauthable, omniauth_providers: [:twitter]
  validates :login,:first_name, :last_name, length: {maximum: 50}
  #has_many :oauth_accounts, dependent: :destroy
  has_one :profile, dependent: :destroy
  has_many :evaluations, class_name: "RSEvaluation", as: :source
  has_many :entries
  acts_as_voter
  has_many :social_providers, dependent: :destroy

  # update from OAuth
  def update_from_oauth(auth, provider_type)
    self.email = auth[:info][:email] if self.email.blank?
    case provider_type
      when :twitter
        name = auth[:info][:name].split(' ')
        self.first_name ||= name[0]
        self.last_name ||= name[1]
    end
  end


  def role?(role_name)
    role == role_name
  end

=begin
  def self.from_omniauth(auth, user)
    oauth_data = { provider: auth['provider'], uid: auth['uid'] }
    oauth_account = OauthAccount.find_or_initialize_by(oauth_data)

    user ||= oauth_account.user || create_empty_user!
    oauth_account.update!(user: user)

    user
  end

  def connected_to?(provider)
    oauth_accounts.by_provider(provider).exists?
  end
=end

  private

=begin
  def self.create_empty_user!
    user = User.new
    user.skip_confirmation!
    user.save!(validate: false)
    user
  end
=end

  def after_confirmation
    ProfileCreator::Email.new(self).perform
  end
end
