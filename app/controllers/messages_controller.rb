class MessagesController < ApplicationController
  
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end
  
  def index
    @messages = @conversation.messages
    if @messages.length > 10
      @over_ten = true
      @messages = @messages[-10..-1]
    end
    
    if params[:m]
      @over_ten = false
      @messages = @conversation.messages
    end
    
    if @messages.last
      if @messages.last.user_id == current_user.id
        @messages.last.read = true
      end
    end
    @message = @conversation.messages.build
  end

  def new
    @message = @conversation.messages.build
  end

  def create
    @message = @conversation.messages.build(message_params)
    @notification = @message.notifications.build(recipient_id: @message.conversation.recipient_id, sender_id: current_user.id)
    if @message.save
      if @message.user_id == @conversation.sender_id
        Pusher['notifications_'+@message.conversation.recipient_id.to_s].trigger('message', {
          messaging: "メッセージが届いています。:#{@message.body}"
        })
      else
        Pusher['notifications_'+@message.conversation.sender_id.to_s].trigger('message', {
          messaging: "メッセージが届いています。:#{@message.body}"
        })
      end
      redirect_to conversation_messages_path(@conversation)
    end
  end
  
  private
    def message_params
      params.require(:message).permit(:body, :user_id)
    end
    
    def sending_pusher
      Notification.sending_pusher(@notification.recipient_id)
    end
end
