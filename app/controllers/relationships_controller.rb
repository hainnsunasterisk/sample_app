 class RelationshipsController < ApplicationController
  before_action :require_logged_in
  before_action :find_create_relationship, only: :create
  before_action :find_destroy_relationship, only: :destroy

  def create
    if @user.blank?
      flash[:danger] = t ".user_not_exist"
      redirect_to root_path
    else
      current_user.follow @user
      redirect_to @user
    end
  end

  def destroy
    if @user.blank?
      flash[:danger] = t ".user_not_exist"
      redirect_to root_path
    else
      current_user.unfollow @user
      redirect_to @user
    end
  end

  private

  def find_create_relationship
    @user = User.find_by id: params[:followed_id]
  end

  def find_destroy_relationship
    @user = Relationship.find(params[:id]).followed
  end
end
