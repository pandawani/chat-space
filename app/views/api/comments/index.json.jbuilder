json.array! @comments do |comment|
  json.body comment.body
  json.image comment.image.url
  json.created_at comment.created_at.strftime("%Y年%m月%d日 %H時%M分")
  json.user_name comment.user.name
  json.id comment.id
end