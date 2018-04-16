json.extract! item, :id, :name, :avg_price, :avg_rating, :description, :created_at, :updated_at
json.url item_url(item, format: :json)