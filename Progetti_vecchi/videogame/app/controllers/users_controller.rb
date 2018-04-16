class UsersController < ApplicationController
    def index
        access = check_access(current_user,"Admin")
        if !(access[:status]) #Error logic goes below
            flash[:warning] = access[:message]
            redirect_to games_path
            return
        end #Normal flux below
        if (params[:search] && (params[:search][:parameter] != "" || params[:search][:role] != "Any"))
            @users = User.search(params[:search])
        else
            @users = User.all
        end
        @users
    end

    def show
        access = check_access(current_user,"Admin")
        if !(access[:status]) #Error logic goes below
            flash[:warning] = access[:message]
            redirect_to games_path
            return
        end #Normal flux below
        @user = User.find(params[:id])
    end

    def new
    end

    def edit
        access = check_access(current_user,"Admin")
        if !(access[:status]) #Error logic goes below
            flash[:warning] = access[:message]
            redirect_to games_path
            return
        end #Normal flux below
        @user = User.find(params[:id])
    end

    def update
        access = check_access(current_user,"Admin")
        if !(access[:status]) #Error logic goes below
            flash[:warning] = access[:message]
            redirect_to games_path
            return
        end #Normal flux below
        @user = User.find(params[:id])
        if (params[:user][:role] == nil)
            params[:user][:role] = @user.role
        end
        @user.update_attributes!(user_params)
        redirect_to @user
    end

    def destroy
        access = check_access(current_user,"Admin")
        if !(access[:status]) #Error logic goes below
            flash[:warning] = access[:message]
            redirect_to games_path
            return
        end #Normal flux below
        @user = User.find(params[:id])
        @user.destroy
        redirect_to users_path
    end

    private
    def user_params
        params.require(:user).permit(:provider, :uid, :name, :oauthtoken, :oauthexpiresat, :email, :role)
    end
end
