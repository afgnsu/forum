json.array!(@posts) do |post|
  json.extract! post, :id, :title, :content, :group_id
  json.url post_url(post, format: :json)
end
