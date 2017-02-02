json.extract! account, :id, :kid_id, :flavor, :balance, :created_at, :updated_at
json.url account_url(account, format: :json)