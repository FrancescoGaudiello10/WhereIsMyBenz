class StaticPagesController < ApplicationController
  def home
    @item = current_user.items.build if logged_in?
    
    @feed_items = current_user.feed.paginate(page: params[:page]) if logged_in?
    @add = current_owner.adds.build if logged_in_owner?
    @feed_adds = current_owner.feed.paginate(page: params[:page]) if logged_in_owner?
  end


  def help
  end
end
