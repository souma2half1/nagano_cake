class Public::OrdersController < ApplicationController
    
 def new
  @order = Order.new
 end

 
 def confilm
     @cart_items = current_customer.cart_items
    if params[:order][:select_address] == "0"
      @order = Order.new(order_params)
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.name
    
    elsif  params[:order][:address_id] == "1"
      @order = Order.new(order_params)
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    
    elsif params[:order][:address_id] == "2"
      @address = Address.new
      @address.postal_code = params[:order][:postal_code]
      @address.address = params[:order][:address]
      @address.name = params[:order][:name]
      @address.customer_id = current_customer.id
    
     if @address.save
       @order.postal_code = @address.postal_code
       @order.address = @address.address
       @order.name = @address.name
      
     else
      render :new
     end
  　end 
    
    end
 
 def create
  order = Order.new(order_params)
  order.save
  redirect_to complete_path
 end 
 
 def index
  @orders = Order.all 
 end
 
 def show
 　@order = current_customer.order
 end
 
 private
 
 def order_params
  params.require(:order).permit(:postal_code, :address, :name, :is_active, :payment,:billing, :postage)
 end
 
 end
 
end
