class Profile < ActiveRecord::Base
  belongs_to :user
  has_many :feeds
  validates :user_id, presence: true
  validates :nickname, presence: true, uniqueness: true, length: {maximum: 50}
  validates :first_name,:last_name, length: {maximum: 50}
  mount_uploader :avatar, AvatarUploader

  #validates :nickname, length: {maximum: 50}
  scope :by_nickname, -> (nickname) { where(nickname: nickname) }

  def self.options
    all.map { |profile| [profile.full_name, profile.id] }
  end

  def name
    [first_name, last_name].select(&:present?).join(' ')
  end

  def full_name
    name.blank? ? nickname : "#{nickname} [#{name}]"
  end
end
