json.extract! donation, :id, :user_id, :project_id, :value, :payment_status, :created_at, :updated_at
json.url donation_url(donation, format: :json)
