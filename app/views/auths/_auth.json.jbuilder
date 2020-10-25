json.extract! auth, :id, :uuid, :secret_token, :created_at, :updated_at
json.url auth_url(auth, format: :json)
