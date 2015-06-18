require_relative 'rolodex'
require_relative 'contact'
require 'sinatra'
require 'sinatra/reloader'

$rolodex ||= Rolodex.new

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

get "/contacts/:id/edit" do
  @contact = $rolodex.search_contact(params[:id].to_i)
  if @contact
      erb :edit_contact
  else
    raise Sinatra::NotFound
  end
end

get "/contacts/:id/delete" do
  @contact = $rolodex.search_contact(params[:id].to_i)
  if @contact
      erb :delete_contact
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

put "/contacts/:id" do
  @contact = $rolodex.search_contact(params[:id].to_i)
  if @contact
    @contact.first_name = params[:first_name]
    @contact.last_name = params[:last_name]
    @contact.email = params[:email]
    @contact.notes = params[:notes]

    redirect to("/contacts")
  else
    raise Sinatra::NotFound
  end
end

delete "/contacts/:id" do
  @contact = $rolodex.delete_contact(params[:id].to_i)
  if @contact
    $rolodex.delete_contact(@contact)
    redirect to("/contacts")
  else
    raise Sinatra::NotFound
  end
end



