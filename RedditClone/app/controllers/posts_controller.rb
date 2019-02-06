class PostsController < ApplicationController

  before_action :require_login, except: [:show]
  before_action :confirm_author, only: [:edit, :update, :destroy]

  def show
    @post = Post.find(params[:id])
    render :show
  end

  def new
    @subs = Sub.all
    @sub = Sub.find(params[:sub_id])
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params)
    @sub = Sub.find(params[:sub_id])
    @post.author_id = current_user.id
    if @post.save
      redirect_to sub_url(@sub)
    else
      @subs = Sub.all
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    @post = Post.find(params[:id])

    if @post.update_attributes(post_params)
      redirect_to sub_url(@post.sub)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end

  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to sub_url(@post.sub)
  end

  private
  def post_params
    params.require(:post).permit(:url, :title, :content, sub_ids: [])
  end

  def confirm_author
    @post = Post.find(params[:id])
    if @post.author != current_user
      flash[:errors] = ["Cannot edit post that does not belong to you"]
      redirect_to subs_url 
    end
  end
end
