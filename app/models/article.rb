class Article < ActiveRecord::Base


	belongs_to :user
	belongs_to :category

	extend FriendlyId
	friendly_id :title, use: :slugged

	acts_as_taggable_on :tags

	def tag_list
  		self.tags.map { |t| t.name }.join(", ")
	end

	def tag_list=(new_value)
	  tag_names = new_value.split(/\s*,\s+/)
	  self.tags = tag_names.map { |name| Tag.where('name = ?', name).first or Tag.create(:name => name) }
	end

	is_impressionable :counter_cache => true

end
