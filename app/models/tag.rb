class Tag < ActiveRecord::Base
	has_and_belongs_to_many :articles,
		:association_foreign_key => 'article_id',
		:class_name => 'Article',
		:join_table => 'articles_tags'
end
