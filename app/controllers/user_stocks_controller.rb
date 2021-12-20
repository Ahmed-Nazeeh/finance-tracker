class UserStocksController < ApplicationController
    def create 
        stock = Stock.check_db(params[:ticker])
        #user_stock_check = current_user.stocks.where(params[:stock_id]).exists?
        if  stock.blank?
            stock = Stock.new_look_up(params[:ticker])
            stock.save
        end
            @user_stock = UserStock.create(user: current_user, stock: stock)
            flash[:notice] = "Stock #{stock.name} was successfully added to your portfolio"
            redirect_to my_portfolio_path
       # elsif user_stock_check == false
           # @user_stock = UserStock.create(user: current_user, stock: stock)
           # flash[:notice] = "Stock #{stock.name} already in the stock and added to your p"
           # redirect_to my_portfolio_path
      #  else
           # flash[:notice] = "Stock #{stock.name} already in the stock and added to your portofolio"
            #redirect_to my_portfolio_path
        
    end

    def destroy
        stock = Stock.find(params[:id])
        UserStock.where(user_id: current_user.id, stock_id: stock.id).first.destroy
        #user_stock = UserStock.where(user_id: current_user.id, stock_id: stock.id)
        #user_stock.destroy
        flash[:notice] = "#{stock.ticker} was successfully removed from portfolio"
        redirect_to my_portfolio_path
    end
end
