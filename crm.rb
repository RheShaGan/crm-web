require 'sinatra'

get '/' do    # Route
  @crm_app_name = "My CRM"
  erb :index
end