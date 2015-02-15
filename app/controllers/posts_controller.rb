 class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]

  def index
    @posts = Post.all
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    # pattern, setup 
    @post = Post.new(post_params) # created private method to sanitize parameters
    @post.creator = User.all.sample # change once we add authentication

    if @post.save
      flash[:notice] = "Your post was created."
      redirect_to post_path(@post)
    else #validation error
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "This post was updated."
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  private
    def post_params
      params.require(:post).permit(:title, :url, :description)
      # requires the top level key to be :post
      # permits with bang allows all attributes
      # rails 3 uses attr_accessible in the model
    end

    def set_post
      @post = Post.find params[:id]
    end
    
end
