class ItemsController < ApplicationController
  def index
    # client = Orchestrate::Client.new("7f1aab23-01c6-4075-bd7f-5dfa0f025fdc")
    app = Orchestrate::Application.new("7f1aab23-01c6-4075-bd7f-5dfa0f025fdc")
    collection = app[:files]
    if !params[:query].blank?
      @items = collection.search(params[:query]).find.map {|item| [item[1].value]}
    else
      @items = collection.map {|item| [item.value]}
    end
    
    if request.xhr?
      render partial: "list", layout: false
    end
  end


  def create
    app = Orchestrate::Application.new("7f1aab23-01c6-4075-bd7f-5dfa0f025fdc")
    collection = app[:files]

    file = params[:file]
    file_json = JSON.parse(File.read(file.tempfile))
    collection << file_json

    if request.xhr?
      render text: true
    end
  end

  def clear_all
    app = Orchestrate::Application.new("7f1aab23-01c6-4075-bd7f-5dfa0f025fdc")
    collection = app[:files]
    collection.destroy!
    redirect_to items_path    
  end

end
