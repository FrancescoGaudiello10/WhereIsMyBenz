class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  # GET /items
  # GET /items.json
  
  def index
    
    if (params[:category])
      @items=Item.tagged_with(params[:category]).paginate(page:params[:page]).per_page(10)    
    else
     if (params[:name] || params[:avg_rating]|| params[:min_price] || params[:max_price]||params[:category_search])
       @items2 = Item.search(params[:name], params[:avg_rating], params[:min_price], params[:max_price]).all
       category_search_var=params[:category_search]
       if(category_search_var!="selectone")           
           @items=[]
           @items2.each do |item|
              if item.tag_list.include?(category_search_var)
                  @items.push(item)
       	      end     
           end
         @items= @items.paginate(:page=>params[:page],:per_page=>10)  
       else 
         @items=@items2.paginate(page:params[:page]).per_page(10)
       end     
     else
      @items=Item.all.paginate(page:params[:page]).per_page(10)
     end
   end
  end
    
  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    if(params[:item][:tag_list]!=nil)
    params[:item][:tag_list] = params[:item][:tag_list].join(',') end
    @item = current_user.items.build(item_params)
    if @item.save
      flash[:success] = "item created!"
      redirect_to item_path(@item)
    else
      @feed_items = []
      redirect_to  root_url
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy    
    @item.destroy
    flash[:success] = "Item deleted"
    redirect_to request.referrer || root_url
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :avg_price, :avg_rating, :description, :picture, :tag_list)
    end
 
    def correct_user
      @item = current_user.items.find_by(id: params[:id])
      redirect_to root_url if @item.nil?
    end
    
    
    
end
