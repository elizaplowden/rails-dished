json.array! @notifications do |notification|
  #json.recipient notification.recipient
  json.actor notification.actor.username
  json.action notification.action
  json.notifiable notification.notifiable
  json.url recipe_path(notification.notifiable.recipe, anchor: dom_id(notification.notifiable))
end
