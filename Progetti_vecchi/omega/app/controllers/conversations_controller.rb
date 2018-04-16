class ConversationsController < ApplicationController

  def index
    @conversations = current_user.mailbox.conversations
  end

  def show
    @conversation = current_user.mailbox.conversations.find(params[:id])
  end

  def create
    if (params[:user_id] == nil || params[:body] == nil || params[:subject] == nil)
      flash[:error] = 'Riempire tutti i campi'
      redirect_back(fallback_location: root_path)
    else
      recipient = User.find(params[:user_id])
      receipt = current_user.send_message(recipient, params[:body], params[:subject])
      current_user.notify(recipient, "", nil, true, nil, false)
      redirect_to conversation_path(receipt.conversation)
    end
  end

  def new
    @recipients = User.where("id != ? and id != ?", 1, current_user.id)
  end

  def destroy
    @conversation = current_user.mailbox.conversations.find(params[:id])
    @conversation.destroy
    respond_to do |format|
      format.html { redirect_to conversations_url, notice: 'Messaggio correttamente eliminato!' }
      format.json { head :no_content }
    end
  end
end
