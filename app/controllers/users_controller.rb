class UsersController < ApplicationController
  def my_portfolio
      @users = User.all
      @tracked_stocks = current_user.stocks
  end

  
end
