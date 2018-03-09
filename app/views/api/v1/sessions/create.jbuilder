json.token @session.token
json.profile do
  json.partial! 'api/v1/mine/profiles/profile', profile: @session.user.profile
end
