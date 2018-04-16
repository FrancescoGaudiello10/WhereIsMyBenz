class AdsController < ApplicationController

	def show
        access = check_access(current_user,"Active")
        if !(access[:status]) #permission check
            flash[:warning] = access[:message]
            redirect_to games_path(@game)
            return
        end
        id = params[:id]
        @ad = Ad.find(id)
        @game = Game.find(params[:game_id])
        @person = @ad.user.name
	end

	def new
        @game = Game.find(params[:game_id])
        maker = current_user
        access = check_access(maker,"Active")
        if !(access[:status]) #permission check
            flash[:warning] = access[:message]
            redirect_to game_reviews_path(@game)
            return
        elsif (maker.ads.any? {|ad| ad.game.id == @game.id})
            flash[:warning] = 'You have already created an ad for this game'
            redirect_to game_reviews_path(@game)
        else
            @ad = @game.ads.build
    	end
    end

	def create
        params.require(:ad)
        params.permit!
        maker = current_user
        
        @game=Game.find(params[:game_id])
        if (maker.ads.any? {|ad| ad.game.id == @game.id})
            flash[:warning] = 'You have already created an ad for this game'
            redirect_to game_reviews_path(@game)
        else
            maker.ads << @game.ads.build(params[:ad])
            redirect_to game_reviews_path(@game)
        end
	end

	def destroy
        @ad = Ad.find(params[:id])
        @game=Game.find(params[:game_id])
        user_target = current_user
        if (user_target == nil)
            flash[:warning] = 'You must be logged in to remove ads'
            redirect_to game_reviews_path(@game)
        elsif ((user_target.ads.any? {|ad| ad.id == @ad.id} && user_target.role != 'Banned')|| user_target.role == 'Admin')
            @ad.destroy
            flash[:notice] = "Ad removed"
            redirect_to game_reviews_path(@game)
        else
            flash[:warning] = 'cant remove an ad if you have not created it or banned'
            redirect_to game_reviews_path(@game)
        end
    end
end
