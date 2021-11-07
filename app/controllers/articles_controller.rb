class ArticlesController < ApplicationController
   def new
    @article= Article.new
   end

   def index
      @articles= Article.all
   end

   def show
      @article=Article.find(params[:id])
   end

   def destroy
      @article=Article.find(params[:id])
      @article.destroy
      flash[:danger]="Article Deleted"
      redirect_to article_path
   end


   def create
      @article= Article.new(article_params)
      @article.user= User.first
      if @article.save
         flash[:success]="Article was Created"
         redirect_to article_path(@article)         
      else
         render 'new'
      end
   end

   def edit
      @article=Article.find(params[:id])
   end

   def update
      @article=Article.find(params[:id])
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
end