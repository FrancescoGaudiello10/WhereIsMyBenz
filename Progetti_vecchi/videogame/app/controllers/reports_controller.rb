class ReportsController < ApplicationController

    def index
        access = check_access(current_user,"Admin")
        if !(access[:status]) #Error logic goes below
            flash[:warning] = access[:message]
            redirect_to games_path
            return
        end #Normal flux below
        @reports = Report.all
    end

    def show
        access = check_access(current_user,"Admin")
        if !(access[:status]) #Error logic goes below
            flash[:warning] = access[:message]
            redirect_to games_path
            return
        end #Normal flux below
        @report = Report.find(params[:id])
        @from = User.find(@report.user_id)
        @target = nil
        @type = nil
        if @report.game_id != nil
            @target = Game.find(@report.game_id)
            @type = "Game"
        elsif @report.ad_id != nil
            @target = Ad.find(@report.ad_id)
            @type = "Ad"
        elsif @report.review_id != nil
            @target = Review.find(@report.review_id)
            @type = "Review"
        end
    end

    def new
        @oldparams = params
    end

    def create
        access = check_access(current_user,"Active")
        if !(access[:status]) #Error logic goes below
            flash[:warning] = access[:message]
            redirect_to games_path
            return
        end #Normal flux below
        user_id = current_user
        target = nil
        if params[:game_target] != nil
            target = Game.find(params[:game_target])
        elsif params[:ad_target] != nil
            target = Ad.find(params[:ad_target])
        elsif params[:review_target] != nil
            target = Review.find(params[:review_target])
        end
        if user_id && (target != nil)
            @report = Report.new(report_params)
            user_id.reports << @report
            target.reports << @report
            @report.save
            flash[:warning] = "Report sent succesfully"
            redirect_to games_path
        else
            flash[:warning] = "Something went wrong"
            redirect_to games_path
        end
    end

    def destroy
        access = check_access(current_user,"Admin")
        if !(access[:status]) #Error logic goes below
            flash[:warning] = access[:message]
            redirect_to games_path
            return
        end #Normal flux below
        @report = Report.find(params[:id])
        @report.destroy
        redirect_to reports_path
    end

    private
    def report_params
        params.require(:report).permit!
    end
end
