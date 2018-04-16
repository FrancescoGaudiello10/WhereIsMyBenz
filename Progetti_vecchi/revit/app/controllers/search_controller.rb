class SearchController < ApplicationController

  def index
  #store all the projects that match the name searched
  @users= User.search(params[:search]).all.paginate(page:params[:page]).per_page(5)
  @owners = Owner.search(params[:search]).all.paginate(page:params[:page]).per_page(5)
  #store all the clients that match the name searched    
  #@clients = Client.where("name LIKE ? ", "%#{params[:client]}%")
  end

end


 
