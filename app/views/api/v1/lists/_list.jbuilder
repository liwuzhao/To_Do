json.extract! list, :id
json.list_date list.list_date.to_s

json.user do
  json.extract! list.user, :nick_name, :avatar_url
end

json.should_do do
  json.extract! list.should_do, :content
end
