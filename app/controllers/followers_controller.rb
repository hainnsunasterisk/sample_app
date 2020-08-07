class FollowersController < ApplicationController
  before_action :require_logged_in, :find_user, only: :index

  def index
    if @users = @user.followers.page(params[:page]).per Settings.pages.limit
      render "users/show_follow"
    else
      flash[:danger] = t ".errors"
      redirect_to users_path
    end
  end
end
