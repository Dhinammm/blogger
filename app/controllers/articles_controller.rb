class ArticlesController < ApplicationController
    def index
        @article = Article&.all
    end

    def show
        begin
            @article = Article&.find(params[:id])
            @user = @article.user_id
        rescue
            not_found_method
        end
    end

    def new
        if current_user != User.find_by(id: params[:user_id])
            sign_out current_user
            redirect_to new_user_session_path
            return
        end
        @article = Article.new
    end

    def create
        @article = Article.new(article_params)
        if @article.save
            redirect_to @article
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        begin
            @article = Article.find(params[:id])
            id = @article.user_id
            user = User.find(id)
            if current_user != user
                sign_out current_user
                redirect_to new_user_session_path
                return
            end
        rescue
            not_found_method
        end
    end

    def update
        @article = Article.find(params[:id])
        if @article.update(article_params)
            redirect_to @article
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        article = Article.find(params[:id])
        id = article.user_id
        user = User.find(id)
        if current_user != user
            sign_out current_user
            redirect_to new_user_session_path
            return
        end
        article.destroy
        redirect_to user_path(user)
    end

    def not_found_method
        render file: Rails.public_path.join('404.html'), status: :not_found, layout: true
    end

    private
    def article_params
        params.expect(article: [:title, :content, :user_id])
    end
end
