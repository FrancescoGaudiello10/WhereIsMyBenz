class ContactsController < ApplicationController
  before_action :admin_user, only: [:index, :destroy]
  def index
    @contacts = Contact.all.order("created_at DESC")
  end
  
  def new
    @contact = Contact.new
  end
  
  def create
    @contact = Contact.new(contact_params)
    
    if @contact.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy
    Contact.find(params[:id]).destroy
    flash[:success] = "contact deleted"
    redirect_to contacts_url

  end
  
  private
  
    def contact_params
      params.require(:contact).permit(:title, :description, :author)
    end
    
    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
    
end
