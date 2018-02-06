json.extract! list, :id
json.list_date I18n.localize(mistake.made_at, format: :Ymd)

json.should_do do
  json.extract! mistake.should_do, :content
  json.extract! list.should_do, :content
end
