class GamesController < ApplicationController

    def index
        if (params[:search] && params[:search][:parameter] != "")
            @games = Game.search(params[:search])
        else
            @games = Game.all
        end
        @games
    end

    def new
        access = check_access(current_user,"Active")
        if !(access[:status]) #permission check
            flash[:warning] = access[:message]
            redirect_to games_path
            return
        end
        @game = Game.new
    end

    def create
        params.require(:game)
        params.permit!

        maker = current_user
        @game = Game.new(params[:game])
        if @game.save
            maker.games << @game
            flash[:notice] = "#{@game.name} was added"
            redirect_to games_path
        else
            render 'new'
        end
    end

    def edit
        @game = Game.find params[:id]
        user_target = current_user
        if (user_target == nil)
            flash[:warning] = 'You must be logged in to edit games'
            redirect_to game_reviews_path(@game)
        elsif ((user_target.role != 'Banned' && user_target.games.any? {|game| game.name == @game.name}) || user_target.role == 'Admin')
            return
        else
            flash[:warning] = 'cant edit a game if you have not created it or banned'
            redirect_to game_reviews_path(@game)
        end
    end

    def update
        params.require(:game)
        params.permit!

        @game = Game.find params[:id]
        if @game.update_attributes(params[:game])
            flash[:notice] = "#{@game.name} was successfully updated"
            redirect_to game_reviews_path(@game)
        else
            render 'edit'
        end
    end

    def destroy
        @game = Game.find(params[:id])
        user_target = current_user
        if (user_target == nil)
            flash[:warning] = 'You must be logged in to remove games'
            redirect_to game_reviews_path(@game)
        elsif (user_target.games.any? {|game| game.name == @game.name} || user_target.role == 'Admin')
            @game.destroy
            flash[:notice] = "Game '#{@game.name}' removed"
            redirect_to games_path
        else
            flash[:warning] = 'cant remove a game if you have not created it'
            redirect_to game_reviews_path(@game)
        end
    end
end
