class ResponsesController < ApplicationController
    def index
        user_target = current_user
        access = check_access(user_target,"Active")
        if !(access[:status]) #permission check
            flash[:warning] = access[:message]
            redirect_to games_path(@game)
            return
        end
        @responses = []
        user_target.ads.each do |ad|
            ad.responses.each do |response|
                @responses.append(response)
            end
        end
    end
    
    def show
        access = check_access(current_user,"Active")
        if !(access[:status]) #permission check
            flash[:warning] = access[:message]
            redirect_to games_path(@game)
            return
        end
        @response = Response.find(params[:id])
    end
    
    def create
        @ad = Ad.find(params[:ad_id])
        maker = current_user
        access = check_access(maker,"Active")
        if !(access[:status]) #permission check
            flash[:warning] = access[:message]
            redirect_to game_reviews_path(@ad.game)
            return
        elsif (maker.responses.any? {|response| response.ad.id == @ad.id})
            flash[:warning] = 'You have already responded to that ad'
        else
            maker.responses << @ad.responses.build
            flash[:notice] = 'Messaggio inviato'
        end
        redirect_to game_reviews_path(@ad.game)
    end
    
    def destroy
        access = check_access(current_user,"Active")
        if !(access[:status]) #permission check
            flash[:warning] = access[:message]
            redirect_to games_path
            return
        end
        @response = Response.find(params[:id])
        @response.destroy
        flash[:notice] = 'Message deleted'
        redirect_to responses_path
    end

end
