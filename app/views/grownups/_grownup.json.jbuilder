json.extract! grownup, :id, :fname, :lname, :email, :password, :admin_level, :created_at, :updated_at
json.url grownup_url(grownup, format: :json)