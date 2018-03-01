json.extract! list, :id
json.list_date list.list_date.to_s

json.user do
  json.extract! list.user, :nick_name, :avatar_url
end

json.should_dos do
  json.array! list.should_dos do |should_do|
    json.id should_do.id
    json.content should_do.content
    json.status should_do.status
  end
end
