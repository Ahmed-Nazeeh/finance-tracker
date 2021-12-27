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

    def update
        @tracked_stocks = current_user.stocks
            #stock = Stock.new_look_up(params[:ticker])
            #byebug
            #x = Stock.find(params[:id]).update(last_price: stock.last_price)
            #byebug
            #flash[:notice] = "Stock #{stock.name} updated"
            #redirect_to my_portfolio_path

        #stock_id = 2   #<<<<<<<<<<<<<<<<<<<<<<<<< delete
        @tracked_stocks.ids.each do |stock_id|   #<<<<<<<<<<<<<<<<<<<<<<<<uncomment
            stock_from_db = Stock.find(stock_id)
            stock = Stock.new_look_up(stock_from_db.ticker)
            stock_from_db.update(last_price: stock.last_price)
        end  #<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< uncomment
        
        #respond_to do |format|
            #format.js {render partial: 'users/prices_update'}
            #flash.now[:notice] = "Stocks updated"
          #end
        flash[:notice] = "Stocks has been updated"
        redirect_to my_portfolio_path
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
