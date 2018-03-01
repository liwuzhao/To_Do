json.array! @should_dos do |should_do|
  json.id should_do.id
  json.content should_do.content
  json.status should_do.status
end
