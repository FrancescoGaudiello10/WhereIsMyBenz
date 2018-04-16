class ReviewsController < ApplicationController
  
  
  before_action :set_review, only: [:show, :update, :destroy, :upvote, :downvote]
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  # GET /reviews
  # GET /reviews.json
  def index
    @reviews = Review.all.paginate(page: params[:page]).per_page(10)
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
    @item = Item.find(params[:item_id])
    @reviews = @item.reviews.find(params[:id])
  end

  # GET /reviews/new
  def new
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews
  # POST /reviews.json
  #def create
   # @review = Review.new(review_params)

   # respond_to do |format|
   #   if @review.save
   #     format.html { redirect_to @review, notice: 'Review was successfully created.' }
    #    format.json { render :show, status: :created, location: @review }
   #   else
  #      format.html { render :new }
  #      format.json { render json: @review.errors, status: :unprocessable_entity }
   #   end
  #  end
 # end
  def create
    @item = Item.find(params[:item_id])
    @review = @item.reviews.build(review_params)
    @review.user_id = current_user.id
    if @review.save
      flash[:success] = "review created!"
      lower_price(@item)
      media_stellina(@item)
      best_price_location(@item)
      @item.increment!(:count, by = 1)
      redirect_to @item
    else
      flash[:error] = "review was not posted!"
      redirect_to @item
    end
  end


  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    if @review.update_attributes(review_params)
      redirect_to @review.item
    else
      render 'edit'
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @item = Item.find(params[:item_id])
    @reviews = @item.reviews.find(params[:id])
    @reviews.destroy
    lower_price(@item)
    media_stellina(@item)
    best_price_location(@item)
    @item.decrement!(:count, by = 1)
    redirect_to item_path(@item)
  end
  
  
  def upvote
    @review.upvote_from current_user
    redirect_to @review.item
  end
  
  def downvote
    @review.downvote_from current_user
    redirect_to @review.item
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      item = Item.find(params[:item_id])
      @review = item.reviews.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:comment, :price, :rating, :store, :store_location)
    end

    # Confirms the correct user.
    def correct_user
      
      @user = User.find_by id: @review.user.id
      redirect_to(root_url) unless current_user?(@user)
    end
    
    # Minimum
    def lower_price(item)
        item.avg_price = item.reviews.minimum(:price)
        item.save
    end
    
    #AVG Rating
    def media_stellina(item)
        item.avg_rating = item.reviews.average(:rating)
        item.save
    end

    #location
    def best_price_location(item)
      item.store_location = item.reviews.where(price: item.reviews.minimum(:price)).limit(1).pluck(:store_location)[0]
      item.latitude = item.reviews.where(price: item.reviews.minimum(:price)).limit(1).pluck(:latitude)[0]
      item.longitude = item.reviews.where(price: item.reviews.minimum(:price)).limit(1).pluck(:longitude)[0]
      item.save
    end

    
    
end
