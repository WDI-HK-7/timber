json.array! @posts do |post|
  json.user_id    post.user_id
  json.id         post.id
  json.title      post.title
  json.content    post.content
  json.created_at post.created_at
  json.updated_at post.updated_at
  json.picture    post.picture
end
