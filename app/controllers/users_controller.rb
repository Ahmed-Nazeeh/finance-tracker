class UsersController < ApplicationController
  def my_portfolio
      #@users = User.all
      @tracked_stocks = current_user.stocks
  end

  def my_friends
    @friends = current_user.friends
  end

  def search 
    #byebug
    #render json: params[:friend]
    if params[:friend].present?
      @friends = User.search(params[:friend])
      #byebug
      if @friends
          respond_to do |format|
            format.js {render partial: 'users/friend_result'}
          end
      else
          respond_to do |format|
            flash.now[:alert] = "Couldn`t find user"
            format.js {render partial: 'users/friend_result'}
          end
      end
    else
          respond_to do |format|
              flash.now[:alert] = "Please enter a friend name ot email to search"
              format.js {render partial: 'users/friend_result'}
          end
    end
  end

 
end
