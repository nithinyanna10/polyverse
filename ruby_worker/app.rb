require 'sinatra'
require 'json'

# 🟥 Ruby Worker Service
# Background job processing service

set :port, 8084
set :bind, '0.0.0.0'

get '/health' do
  content_type :json
  {
    service: 'Ruby Worker',
    status: 'operational',
    version: '0.1.0'
  }.to_json
end

post '/jobs' do
  content_type :json
  job_data = JSON.parse(request.body.read)
  
  {
    job_id: SecureRandom.uuid,
    status: 'queued',
    data: job_data,
    created_at: Time.now.iso8601
  }.to_json
end

get '/jobs/:id' do
  content_type :json
  {
    job_id: params[:id],
    status: 'processing',
    progress: 50
  }.to_json
end

