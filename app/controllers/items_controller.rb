class ItemsController < ApplicationController
  def index
    @item = Item.new
    @items = Item.all
  end


  def create
    @item  = Item.new
    file = params[:item][:data]
    @item.data = JSON.parse(File.read(file.tempfile))
    @item.save!
    redirect_to items_path unless request.xhr?
  end
end
