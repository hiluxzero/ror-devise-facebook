class ArticlesController < ApplicationController
	before_action :set_article, only: [:show,:edit,:update,:destroy]
	def index
		@articles = Article.all
	end
	def new
		@article = Article.new
	end
	def show
		@article = Article.find(params[:id])
	end
	def edit

	end
	def update
		respond_to do |format|
			if @article.update(article_params)
				format.html{redirect_to  @article, notice: 'Article was successfully updated'}
				format.json{render :show, status: :ok, location: @article }
			else
				format.html{render :edit}
				format.json{render json: @article.errors, status: :unprocessable_entity}
			end	
		end
	end
	def destroy
		unless  @article.photo.nil?
			File.delete(Rails.root.join('public', 'uploads', @article.photo)) if File.exist?(Rails.root.join('public', 'uploads', @article.photo))
		end
		@article.destroy
		respond_to do |format|
			format.html{redirect_to articles_path, notice: 'The article was successfully destroyed.'}
			format.json{head :no_content}
		end
	end	
	def create
		@article = Article.new(article_params)

		@article.user_id = current_user.id
		@article.approved = 0

		uploaded_io = params[:article][:photo]
		File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
			file.write(uploaded_io.read)
		end
		@article.photo = uploaded_io.original_filename

		respond_to do |format|
			if  @article.save
				
				format.html {redirect_to @article, notice: 'Article was successfully created'}
				format.json {render :show, status: :created, location: @article}
			else
				format.html { render :new}
				format.json {render json: @article.errors, status: :unprocessable_entity}
			end	
		end
	end
	private
		def set_article
			@article = Article.find(params[:id])
		end
		def article_params
			params.require(:article).permit(:name,:user_id,:description,:photo,:approved,:urlsource,{:tag_ids => []})
		end
end
