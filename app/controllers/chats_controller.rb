class ChatsController < ApplicationController
  def show
    @content = Chat.all
  end

  def create
    @contents = Chat.new(content: params[:message])
    @contents.save
    redirect_to chats_path
  end
end
