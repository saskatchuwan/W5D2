class SubsController < ApplicationController

  before_action :require_login, only: [:new, :create, :edit, :update]
  before_action :confirm_moderator, only: [:edit, :update]
  def index
    @subs = Sub.all
    render :index
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def new
    @sub = Sub.new
    render :new
  end

  def create 
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id

    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    @sub = Sub.find(params[:id])

    if @sub.update_attributes(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  private
  def confirm_moderator
    @sub = Sub.find(params[:id])
    if @sub.moderator != current_user
      flash[:errors] = ["Cannot edit sub that does not belong to you"]
      redirect_to subs_url 
    end
  end

  def sub_params
    params.require(:sub).permit(:description, :title)
  end
end
