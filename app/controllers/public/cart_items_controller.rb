class Public::CartItemsController < ApplicationController
 
def index
 @cart_items = current_customer.cart_items
end

def create
 

  @cart_item = CartItem.new(cart_item_params) 
  @cart_item.customer_id = current_customer.id
  
  
  @cart_items = current_customer.cart_items.all
  @cart_item_u = @cart_items.find_by(item_id: params[:cart_item][:item_id])
  
 if @cart_item_u
  @new_amount = @cart_item.amount+@cart_item_u.amount
  @cart_item_u.update(amount: @new_amount)
  @cart_item.delete
 end 
 
@cart_item.save
redirect_to cart_items_path
end


 def update
  cart_item = CartItem.find(params[:id])
  cart_item.update(amount: params[:cart_item][:amount])
  redirect_to cart_items_path
 end


private
  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
  end
# hint if文を使う
 #@cart_item_u = @cart_items.find_by(item_id: params[:cart_item][:item_id])


end
