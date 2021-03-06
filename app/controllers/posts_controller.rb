 class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:index, :show]
  before_action :require_creator, only: [:edit, :update]

  def index
    @posts = Post.all.sort_by{|x| x.total_votes}.reverse

    respond_to do |format|
      format.html
      format.json { render json: @posts }
      format.xml { render xml: @posts }
    end
  end

  def show
    @comment = Comment.new

    respond_to do |format|
      format.html
      format.json { render json: @post }
      format.xml { render xml: @post }
    end
  end

  def new
    @post = Post.new
  end

  def create
    # pattern, setup 
    @post = Post.new(post_params) # created private method to sanitize parameters
    @post.creator = current_user # TODO change once we add authentication
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

  def vote
    @vote = Vote.create(voteable: @post, creator: current_user, vote: params[:vote])

    respond_to do |format|
        format.html do
          if @vote.valid?
            flash[:notice] = "Your vote was counted."
          else
            flash[:error] = "You can only vote on a post once."
          end

          redirect_to :back
        end
        format.js
    end
  end

  private
    def post_params
      params.require(:post).permit(:title, :url, :description, category_ids: [])
      # requires the top level key to be :post
      # permits with bang allows all attributes
      # rails 3 uses attr_accessible in the model
    end

    def set_post
      @post = Post.find_by slug: params[:id]
    end

    def require_creator
      access_denied unless logged_in? && (current_user == @post.creator || current_user.admin?)
    end 
end
