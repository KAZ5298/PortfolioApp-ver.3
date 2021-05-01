class ChatChannel < ApplicationCable::Channel
  include SessionsHelper
  
  def subscribed
    stream_form 'chat_channel'
    stream_for current_user.id
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    if data["content"]
      Chat.create!(
        user_id: data["current_user_id"].to_i,
        partner_id: data["partner_id"].to_i ,
        content: data["content"]
      )
      #画面を開いているのがチャット送信者だった場合
      ChatChannel.broadcast_to data["current_user_id"].to_i,
        content: data["content"],
        partner_id: data["partner_id"],
        isCurrent_user: true

      #画面を開いているのがチャット受信者だった場合
      ChatChannel.broadcast_to data["partner_id"].to_i,
        content: data["content"],
        partner_id: data["partner_id"],
        isCurrent_user: false
    end
  end
end
