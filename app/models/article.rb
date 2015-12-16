class Article < ActiveRecord::Base


	belongs_to :user
	belongs_to :category

	extend FriendlyId
	friendly_id :title, use: :slugged

	acts_as_taggable

end
