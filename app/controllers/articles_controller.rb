class ArticlesController < ApplicationController

	before_action :find_article, only: [:show, :edit, :update, :destroy]
	autocomplete :tag, :name

	def index
		if params[:category].blank? and params[:tag].blank?
			@articles = Article.all.order("created_at DESC").paginate(page: params[:page], per_page: 6)
		elsif !params[:category].blank?
			@category_id = Category.find_by(name: params[:category]).id
			@articles = Article.where(category_id: @category_id).order("created_at DESC").paginate(page: params[:page], per_page: 15)
		elsif params[:tag]
			@articles = Article.all.tagged_with(params[:tag]).order("created_at DESC").paginate(page: params[:page], per_page: 15)
		end
	end

	def show
		impressionist(@article)		
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
		params.require(:article).permit(:title, :tag_list, :content, :category_id, :slug)
	end

end
