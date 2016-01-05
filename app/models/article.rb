class Article < ActiveRecord::Base
	has_and_belongs_to_many :tags,
		:association_foreign_key => 'tag_id',
		:class_name => 'Tag',
		:join_table => 'articles_tags'
	belongs_to :user
end
