require 'digest/md5'
require 'mechanize'

class Feed < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use:[:slugged, :finders]
  has_many :entries, dependent: :destroy
  validates :url, uniqueness: true
  belongs_to :profile
  has_many :users, through: :profiles
  validates :url, :url => true
  def score
    self.get_upvotes.size - self.get_downvotes.size
  end

  def secret
		Digest::MD5.hexdigest(created_at.to_s)
  end

  def notified params
    update_attributes(:status => params["status"]["http"])
    params['items'].each do |i|
  		entries.create(:atom_id => i["id"], :title => i["title"], :url => i["permalinkUrl"], :content => i["content"])
  	end
  end

  def parse_title(url)
    content = Mechanize.new.get(url)
    if content.respond_to?('title')
      feed = content.title
    else
      Nokogiri::XML(content.body).at('//channel//title').text
    end
  end

end
