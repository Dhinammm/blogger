class UsersController < ApplicationController
    def index
        @users = User.all
    end

    def show
        begin
            @user = User.find(params[:id])
            @articles = Article.where("user_id = ?",params[:id])
        rescue
            render file:Rails.public_path.join('404.html'), status: :not_found, layout: true
        end
    end

    def new 
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to @user
        else
            render :new, status: :unprocessable_entity
        end
    end

    def destroy
        begin
        user = User.find(params[:id])
        if current_user != user
            sign_out current_user
            redirect_to new_user_session_path
            return
        end
        user.destroy
        redirect_to users_path
        rescue
            render file:Rails.public_path.join('404.html'), status: :not_found, layout: true
        end
    end

    private

    def user_params
        params.expect(user: [:name, :email, :password])
    end
end
