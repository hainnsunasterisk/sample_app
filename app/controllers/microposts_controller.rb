class MicropostsController < ApplicationController
  before_action :require_logged_in, only: %i(create, :destroy)
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build micropost_params
    @micropost.image.attach micropost_params[:image]
    if @micropost.save
      flash[:success] = t "common.success"
      redirect_to root_url
    else
      @feed_items = current_user.feed.page(params[:page]).per Settings.pages.limit
      render "static_pages/home"
    end
  end

  def destroy
    if @micropost.destroy
      flash[:success] = t "common.success"
      redirect_to request.referrer || root_url
    else
      flash[:danger] = t "common.errors"
      redirect_to root_path
    end
  end

  private

  def micropost_params
    params.require(:micropost).permit Micropost::MICROPOST_PARAMS_PARAMS
  end

  def correct_user
    @micropost = current_user.microposts.find_by id: params[:id]
    redirect_to root_url unless @micropost
  end
end
