$(function(){

  let search_user = $('#user-search-result');

  function buildHTML(users){
    if(users.length === 0){
      let html =
      `
      <div class="chat-group-user clearfix">
        <p class="chat-group-user__name">ユーザーが見つかりません</p>
      </div>
      `
      search_user.append(html)

    }else{
      let html =
      `
      <div class="chat-group-user clearfix">
        <p class="chat-group-user__name">${users.name}</p>
        <a class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id=${users.id} data-user-name=${users.name}>追加</a>
      </div>
      `
      search_user.append(html)
    };
  };

  function addUsersHTML(SelectName, SelectId){
    let html =
    `
    <div class='chat-group-user'>
      <input name='group[user_ids][]' type='hidden' value='${SelectId}'>
      <p class='chat-group-user__name'>${SelectName}</p>
      <div class='user-search-remove chat-group-user__btn chat-group-user__btn--remove js-remove-btn'>削除</div>
    </div>
    `
    $('#chat-group-users').append(html)
  }

  $('#user-search-field').on('keyup',function(){
    let input = $('#user-search-field').val();

  $.ajax({
    type: 'GET',
    url: '/users',
    dataType: 'json',
    data: {keyword:input},
  })
  .done(function(users){
    search_user.empty();
    if(users.length !== 0){
      users.forEach(function(user){
      buildHTML(user);
    }
    )}else{
      buildHTML(users)
    }
  })
  .fail(function(){
    alert("ユーザー検索に失敗しました");
  })
  });



  $('.chat-group-form__field--right').on('click','.user-search-add',function(){
    let SelectName = $(this).data('user-name');
    let SelectId = $(this).data('user-id');
    $(this).parent().remove();
    addUsersHTML(SelectName,SelectId)
  });

  $('.chat-group-form__field--right').on('click','.user-search-remove',function(){
    $(this).parent().remove();
  });



});