class Entry < ActiveRecord::Base
	searchkick autocomplete: [:title]
	acts_as_votable
	belongs_to :feed
	has_many :comments, :as => :commentable, :dependent => :destroy
	validates :atom_id, uniqueness: {scope: :feed_id}

	default_scope {
		order('created_at DESC')
	}
	def score_entry
		self.get_upvotes.size - self.get_downvotes.size
	end
end
