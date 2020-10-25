json.extract! user, :id, :name, :sirname, :hobby, :created_at, :updated_at
json.url user_url(user, format: :json)
