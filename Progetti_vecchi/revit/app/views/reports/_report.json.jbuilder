json.extract! report, :id, :reported_id, :reporter_id, :comment, :created_at, :updated_at
json.url report_url(report, format: :json)
