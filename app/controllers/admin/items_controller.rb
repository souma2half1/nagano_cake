class Admin::ItemsController < ApplicationController
    
 def index
  @items = Item.page(params[:page])
 end
 
 def new
  @item = Item.new
 end
 
 def create
  @item = Item.new(item_params)
  @item.save
  redirect_to admin_items_path(params[:id])
 end
 
 def show
  @item = Item.find(params[:id])
  @genre = @item.genre
 end 
  
 def edit
  @item = Item.find(params[:id])
 end
 
 def update
   item = Item.find(params[:id])
   item.update(item_params)
   redirect_to admin_item_path(item.id)  
 end
  
 private
 
 def item_params
  params.require(:item).permit(:name,:introduction,:price,:image,:genre_id,:is_active)
 end 
end
