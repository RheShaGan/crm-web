require_relative 'rolodex'
require_relative 'contact'
require 'sinatra'

$rolodex = Rolodex.new

get '/' do    # Route
  @crm_app_name = "My CRM"
  erb :index
end

get "/contacts" do
  # @contacts << Contact.new("Yehuda", "Katz", "yehuda@example.com", "Developer")
  # @contacts << Contact.new("Mark", "Zuckerberg", "mark@facebook.com", "CEO")
  # @contacts << Contact.new("Sergey", "Brin", "sergey@google.com", "Co-Founder")

  erb :contacts
end

get "/contacts/new" do
  erb :new_contact
end

get "/contacts/:id" do
  @contact = $rolodex.search_contact(params[:id].to_i)
  if @contact
    erb :show_contact
  else
    raise Sinatra::NotFound
  end
end

# end of file
post '/contacts' do
  #new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
  $rolodex.add_contact(params[:first_name], params[:last_name], params[:email], params[:note])
  redirect to('/contacts')
end
