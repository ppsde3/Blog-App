class ArticlesController < ApplicationController

   before_action :set_article, only: [:show, :destroy, :edit, :update]
   before_action :require_user, except: [:index, :show]
   before_action :require_same_user, only: [:destroy, :edit, :update]

   def new
    @article= Article.new
   end

   def index
      @articles= Article.paginate(page: params[:page], per_page: 3)
   end

   def show
   end

   def destroy
      @article.destroy
      flash[:danger]="Article Deleted"
      redirect_to article_path
   end


   def create
      @article= Article.new(article_params)
      @article.user= current_user
      if @article.save
         flash[:success]="Article was Created"
         redirect_to article_path(@article)         
      else
         render 'new'
      end
   end

   def edit
   end

   def update
      if @article.update(article_params)
         flash[:success]="Article Updated !"
         redirect_to article_path(@article)
      else
         render 'edit'
      end
   end

   private
   def article_params
      params.require(:article).permit(:title,:description)
   end

   def set_article
      @article=Article.find(params[:id])
   end

   def require_same_user
      if current.user != @article.user && !current_user.admin?
         flash[:danger]= "You can not update another article"
      end
   end
end