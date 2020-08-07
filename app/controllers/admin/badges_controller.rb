class Admin::BadgesController < ApplicationController

  before_action :set_badges, only: :index
  before_action :find_badge, only: :destroy

  def index; end

  def new
    @badge = Badge.new
  end

  def create
    @badge = current_user.badges.new(badge_params)

    if @badge.save
      redirect_to admin_badges_path
    else
      render :new
    end
  end

  def destroy
    @badge.destroy
    redirect_to admin_badges_path
  end

  private

  def badge_params
    params.require(:badge).permit(:title, :image_url, :rule)
  end

  def set_badges
    @badges = Badge.all
  end

  def find_badge
    @badge = Badge.find(params[:id])
  end
end