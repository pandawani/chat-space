$(function(){

  function buildHTML(comment){
    if(comment.image){
      let html = 
      `<div class="post-info" data-comment-id=${comment.id}>
        <div class="post-info__index ">
          <p class="post-info__index__name">${comment.user_name}</p>
          <p class="post-info__index__time">${comment.created_at}</p>
        </div>     
        <div class="post-info__text">
          ${comment.body}
        </div>
        <div class="post-info__text">
          <img src=${comment.image}>
        </div>
      </div>`
      return html;  
    }else{
      let html =
      `<div class="post-info" data-comment-id=${comment.id}>
        <div class="post-info__index">
          <p class="post-info__index__name">${comment.user_name}</p>
          <p class="post-info__index__time">${comment.created_at}</p>
        </div>     
        <div class="post-info__text">
          ${comment.body}
        </div>
      </div>`
      return html;
    };
  }
  $('#new_comment').on('submit',function(e){
    e.preventDefault();
    let formData = new FormData(this);
    let url = $(this).attr('action');
    $.ajax({
      url: url,
      type: 'POST',
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(comment){
      let html = buildHTML(comment);
      $('.chat_main__message-list').append(html);
      $('.chat_main__message-list').animate({ scrollTop: $('.chat_main__message-list')[0].scrollHeight});
      $('#new_comment')[0].reset();
      $('#submit').prop('disabled',false);
    })
    .fail(function(){
      alert("メッセージ送信に失敗しました");
    })
  })

  let reloadComments = function(){
    let last_comment_id = $('.post-info:last').data("comment-id");
    $.ajax({
      url: "api/comments",
      type: 'get',
      dataType:'json',
      data: {id:last_comment_id}
    })
    .done(function(comments){
      if(comments.length !== 0){
        let insertHTML = '';
        $.each(comments, function(i,comment){
          insertHTML += buildHTML(comment)
        });
        $('.chat_main__message-list').append(insertHTML);
        $('.chat_main__message-list').animate({scrollTop: $('.chat_main__message-list')[0].scrollHeight});
      }
    })
    .fail(function(){
      alert('error');
    })
  }
  if (document.location.href.match(/\/groups\/\d+\/comments/)) {
    setInterval(reloadComments, 7000);
  }
});