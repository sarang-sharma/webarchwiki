class ArticlesController < ApplicationController

	before_action :find_article, only: [:show, :edit, :update, :destroy]
	
	
	def index
		if params[:category].blank?
			@articles = Article.all.order("created_at DESC").paginate(page: params[:page], per_page: 6)
		else
			@category_id = Category.find_by(name: params[:category]).id
			@articles = Article.where(category_id: @category_id).order("created_at DESC").paginate(page: params[:page], per_page: 6)
		end
	end

	def show
	end

	def new
		@article = current_admin.articles.build
	end

	def create
		@article = current_admin.articles.build(article_params)
		if @article.save
			redirect_to @article
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @article.update(article_params)
			redirect_to @article
		else
			render 'edit'
		end
	end

	def destroy
		@article.destroy
		redirect_to root_path
	end

	private

	def find_article
		@article = Article.friendly.find(params[:id])
	end

	def article_params
		params.require(:article).permit(:title, :content, :category_id, :slug)
	end

end
