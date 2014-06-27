class PostsController < ApplicationController

    before_action :restrict_to_signed_in, only: [:new, :create]

    def new
        # @post = current_user.posts.build
        @post = Post.new
    end

    def create
        @post = current_user.posts.build(post_params)
        if @post.save
            # redirect_to current_user #root_url
            redirect_to root_path
        end
    end

    def index
        @posts = Post.all
    end

    private

        def post_params
            params.require(:post).permit(:content)
        end

end
