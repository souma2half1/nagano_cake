class Public::OrdersController < ApplicationController
    
 def new
  @order = Order.new
  if !current_customer.cart_items.exists?
   redirect_to cart_items_path
  end
 end
 
 def show
  @order = Order.find(params[:id]) 
 end

 
 
 def confilm
     @cart_items = current_customer.cart_items
   if @cart_items.exists?
     @order = Order.new(order_params)
     @total_price = 0
     @cart_items.each do |cart_item|
      if current_customer.id == cart_item.customer_id
      @total_price+=cart_item.item.price*cart_item.amount
      end
     end
     
     @order.billing = @total_price

    if params[:order][:select_address] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.name
    
    elsif  params[:order][:address_id] == "1"
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
   else
    redirect_to root_path
   end
 end
 
 def create
  @order = current_customer.orders.new(order_params)
  
  if @order.save
   current_customer.cart_items.each do |cart_item|
    order_detail = OrderDetail.new
    order_detail.order_id = @order.id
    order_detail.item_id = cart_item.item_id
    order_detail.price = cart_item.item.price
    order_detail.quantity = cart_item.amount
    order_detail.save
    cart_item.destroy
   end
    
   redirect_to complete_path
  else
  redirect_to orders_path
  end
 end 
 
 def index
  @orders = current_customer.orders.all
 end
 
 def complete
 end
 
 
 
 
 private
 
 def order_params
  params.require(:order).permit(:postal_code, :address, :name, :is_active, :payment,:billing, :postage, :customer_id)
 end
 
end
 
