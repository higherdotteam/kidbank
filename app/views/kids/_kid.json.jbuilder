json.extract! kid, :id, :fname, :lname, :email, :password, :dob, :created_at, :updated_at
json.url kid_url(kid, format: :json)