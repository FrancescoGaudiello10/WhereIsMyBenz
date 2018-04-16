class ReviewsController < ApplicationController

    def index
        access = check_access(current_user,"Guest")
        if !(access[:status]) #permission check
            flash[:warning] = access[:message]
            redirect_to games_path
            return
        end
        @game = Game.find(params[:game_id])
        @reviews = @game.reviews
        @ads = @game.ads

        #avarage_rating method
        sum = 0
        tot = 0
        @reviews.each do |review|
            if review.rating == nil
                review.rating = 10
            end
            sum = sum+review.rating
            tot = tot+1
        end

        if (params[:search] && params[:search][:rating] != "Any" && params[:search][:rating] != "" && params[:search][:rating] != nil)
            @reviews = Review.search(params[:search])
            @rating_search = params[:search][:rating]
        else
            @rating_search = 'Any'
        end

        if (tot == 0)
            @avarage = 'ND'
        else
            @avarage = sum/tot
        end
    end

    def show
        access = check_access(current_user,"Guest")
        if !(access[:status]) #permission check
            flash[:warning] = access[:message]
            redirect_to games_path
            return
        end
        id = params[:id]
        @review = Review.find(id)
        @person = @review.user.name
        @game = Game.find(params[:game_id])
    end

    def new
        @game = Game.find(params[:game_id])
        maker = current_user
        access = check_access(maker,"Active")
        if !(access[:status]) #permission check
            flash[:warning] = access[:message]
            redirect_to game_reviews_path(@game)
            return
        end

        if ! maker.reviews.any? {|review| review.game.name == @game.name}
            @review = @game.reviews.build
        else
            flash[:warning] = 'you have already reviewed this game'
            redirect_to game_reviews_path(@game)
        end
    end

    def create
        params.require(:review)
        params.permit!

        @game = Game.find(params[:game_id])
        maker = current_user
        if maker.reviews.any? {|review| review.game.name == @game.name}
            flash[:warning] = 'you have already reviewed this game'
            redirect_to game_reviews_path(@game)
        else
            @review = @game.reviews.build
            maker.reviews << @game.reviews.build(params[:review])
            redirect_to game_reviews_path(@game)
        end
    end

    def edit
        @game = Game.find params[:game_id]
        @review = Review.find(params[:id])
        user_target = current_user
        if (user_target == nil)
            flash[:warning] = 'You must be logged in to edit reviews'
            redirect_to game_reviews_path(@game)
        elsif ((user_target.name == @review.user.name && user_target.role != 'Banned') || user_target.role == 'Admin')
            return
        else
            flash[:warning] = 'cant edit a review if you have not created it or banned'
            redirect_to game_reviews_path(@game)
        end
    end

    def update
        params.require(:review)
        params.permit!

        @review = Review.find params[:id]
        user_target = current_user
        if (@review.update_attributes(params[:review]))
            flash[:notice] = "review was successfully updated"
            redirect_to game_reviews_path(params[:game_id])
        else
            render 'edit'
        end
    end

    def destroy
        @game = Game.find(params[:game_id])
        @review = Review.find(params[:id])
        user_target = current_user
        if (user_target == nil)
            flash[:warning] = 'You must be logged in to remove reviews'
            redirect_to game_review_path(@game, @review)
        elsif ((user_target.name == @review.user.name && user_target.role != 'Banned') || user_target.role == 'Admin')
            @review.destroy
            flash[:notice] = "Review removed"
            redirect_to game_reviews_path(@game)
        else
            flash[:warning] = 'cant remove a review if you have not created it'
            redirect_to game_review_path(@game,@review)
        end
    end

end
