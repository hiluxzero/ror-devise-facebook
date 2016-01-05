class CreateArticles < ActiveRecord::Migration
	def change
		create_table :articles do |t|
			t.string :name
			t.references :user
			t.string :description
			t.string :photo
			t.integer :approved
			t.string :urlsource
			t.timestamps null: false
		end 
	end
end
