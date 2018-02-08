json.extract! list, :id
json.list_date list.list_date.to_s(:ymd)



json.user do
  json.extract! list.user, :nick_name, :avatar_url
end

json.should_do list.should_do do |should_do|
  json.extract! should_do, :content
end


# if mistake.violate_principles.present?
#   json.violate_principles mistake.violate_principles.active do |principle|
#     json.extract! principle, :id, :name
#   end
#   json.violate_principle_ids mistake.violate_principle_ids
# end
