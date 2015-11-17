class PostsController < ApplicationController

  before_action :require_user, only: [:new, :create, :edit, :update, :destroy]

  def index
    if current_user_session
      follower_ids = ""
      current_user.all_following.each do |f|
        follower_ids = follower_ids +", "+ f.id.to_s
      end
      @posts = Post.select("posts.*").where("user_id IN (" + current_user.id.to_s + follower_ids+")").order(:created_at.to_s + " DESC").page(params[:page]).per(50)
    else
      @posts = Post.select("posts.*").order(:created_at).page(params[:page]).per(50)
    end
  end

  def create
    @post = Post.new(post_params)
    @post.update(user_id: current_user.id)
    if @post.save
      flash[:success] = "Your Post Was a Success!"
      redirect_to root_path
    else
      render :new
    end
  end

  def new
    @posts = Post.all
    @post = Post.new
  end
  def edit
    @post = Post.find(params[:id])
    @post.save
    render :new
  end

  def update
   @post = Post.find(params[:id])
   if @post.update(post_params)
     redirect_to @post
   else
     render "new"
   end
 end

def show
    @posts = Post.find(params[:id])
    render "post"
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    Post.all
    redirect_to root_path
    @post.save

  end


end
