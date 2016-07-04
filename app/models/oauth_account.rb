class OauthAccount < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true
  validates :uid, presence: true
  validates :provider, presence: true

  scope :by_provider, -> (provider) { where(provider: provider) }
end
