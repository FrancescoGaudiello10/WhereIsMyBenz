json.extract! review, :id, :user, :comment, :price, :rating, :store, :item_id, :created_at, :updated_at
json.url review_url(review, format: :json)