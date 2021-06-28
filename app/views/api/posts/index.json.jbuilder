json.data do
  json.posts @resources do |resource|
    json.id resource.id
    json.title resource.title
    json.sub_title resource.sub_title
    json.user_id resource.user_id
    json.user_name resource.user.full_name
    json.created_at resource.created_at
    json.comments resource.comments.each do |comment|
      json.id comment.id.to_s
      json.body comment.body
      json.post_id comment.post_id
      json.user_id comment.user_id
      json.parent_id comment.parent_id
      json.created_at comment.created_at
    end
  end
end


