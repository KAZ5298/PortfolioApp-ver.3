import consumer from "./consumer"

consumer.subscriptions.create("ChatChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },
  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },
  received: function(data) {
    //画面を開いているのがチャット送信者だった場合
    if (data["isCurrent_user"]==true){
      content=`<div class='mycomment'><p>${data["content"]}</p></div>`;
    }
    //画面を開いているのがチャット受信者だった場合
    else{
      content=`<div class='fukidasi'><div class='faceicon'>
      <img src='/assets/profile.png' alt='管理人'></div>
      <div class='chatting'><div class='says'><p>${data["content"]}</p>
      </div></div></div>`;
    }
    $('#chats').append(content);
  },
  speak: function(content) {
    current_user_id=$("#current_user_id").val();
    partner_id=$("#partner_id").val();
    return this.perform('speak',{content: content, current_user_id: current_user_id, partner_id: partner_id});
  }
});
$(function(){
  $("#send").on("click",function(e){
    content=$("#content").val();
    App.chat.speak(content);
    $("#content").val(""); //フォームを空に
    e.preventDefault();
  });
});