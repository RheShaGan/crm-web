require_relative 'rolodex'
require 'sinatra'
require 'sinatra/reloader'
require 'data_mapper'

DataMapper.setup(:default, "sqlite3:database.sqlite3")

$rolodex ||= Rolodex.new

class Contact
  include DataMapper::Resource
  
  property :id, Serial
  property :first_name, String
  property :last_name, String
  property :email, String
  property :notes, Text

  DataMapper.finalize
  DataMapper.auto_upgrade!
  end

  def to_s
    "#{@id}--#{@first_name} #{@last_name} --#{@email}--#{@notes}"
  
  end
end

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

get "/contacts/:id/show_contact" do
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



