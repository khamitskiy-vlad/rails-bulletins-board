json.extract! bulletin, :id, :title, :description, :user_id, :category_id, :created_at, :updated_at
json.url bulletin_url(bulletin, format: :json)
