class BlogCommentsController < ApplicationController
    def create
        @comment = BlogComment.new(params.expect(blog_comment: [:content]))
        @comment.update(user_id: current_user.id, article_id: params[:article_id])
        @comment.save
        redirect_to article_path(params[:article_id]) 
    end

    def destroy
        begin
            comment = BlogComment.find(params[:id])
            @page = Article.find(comment.article_id)
            comment.destroy
            redirect_to @page
        rescue
            render file: Rails.public_path.join('404.html'), status :not_found, layout :true
        end
    end
end
