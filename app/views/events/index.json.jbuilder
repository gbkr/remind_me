json.array!(@reminders) do |reminder|
  json.extract! reminder, :name
  json.url reminder_url(reminder, format: :json)
end
