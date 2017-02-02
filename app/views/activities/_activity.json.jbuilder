json.extract! activity, :id, :account_id, :amount, :action, :created_at, :updated_at
json.url activity_url(activity, format: :json)