json.extract! venue, :id, :name, :coordinates, :created_at, :updated_at
json.url venue_url(venue, format: :json)
