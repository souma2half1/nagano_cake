class Admin::OrdersController < ApplicationController

 def complete
 end
 
 def orders
  @oreder = Order.find(params[]) 
 end
 
 def show
  @order = Order.find(params[id])
 end
    
end
