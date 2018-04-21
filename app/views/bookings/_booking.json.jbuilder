json.extract! booking, :id, :start_date, :end_date, :user_id, :room_id, :created_at, :updated_at
json.url booking_url(booking, format: :json)
