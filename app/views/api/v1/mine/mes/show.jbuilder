json.user do
  json.partial! 'api/v1/mine/profiles/profile', profile: @current_user.profile
end
