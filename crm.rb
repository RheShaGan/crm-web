#require_relative 'rolodex'
require 'sinatra'
require 'sinatra/reloader'
require 'data_mapper'

DataMapper.setup(:default, "sqlite3:database.sqlite3")

#$rolodex ||= Rolodex.new

class Contact
  include DataMapper::Resource
  
  property :id, Serial
  property :first_name, String
  property :last_name, String
  property :email, String
  property :notes, Text
  
end

DataMapper.finalize
DataMapper.auto_upgrade!


get '/' do    # Route
  @crm_app_name = "My CRM"
  erb :index
end

get "/contacts" do
  @contacts = Contact.all
  erb :contacts
end

get "/contacts/new" do
  erb :new_contact
end

get "/contacts/:id/show_contact" do
  @contact = Contact.get(params[:id].to_i)
  if @contact
    erb :show_contact
  else
    raise Sinatra::NotFound
  end
end

get "/contacts/:id/edit" do
  @contact = Contact.get(params[:id].to_i)
  if @contact
      erb :edit_contact
  else
    raise Sinatra::NotFound
  end
end

get "/contacts/:id/delete" do
  @contact = Contact.get(params[:id].to_i)
  if @contact
      erb :delete_contact
  else
    raise Sinatra::NotFound
  end
end


# end of file
post '/contacts' do
  contact = Contact.first_or_create(
    :first_name => params[:first_name],
    :last_name => params[:last_name],
    :email => params[:email],
    :notes => params[:notes]
    )
    
  redirect to('/contacts')
end

put "/contacts/:id" do
  @contact = Contact.get(params[:id].to_i)
  if @contact
   
    @contact.update(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], notes: params[:notes])
  # @contact.save

    redirect to("/contacts")
  else
    raise Sinatra::NotFound
  end
end

delete "/contacts/:id" do
  @contact = Contact.get(params[:id].to_i)
  if @contact
    @contact.destroy

    redirect to("/contacts")
  else
    raise Sinatra::NotFound
  end
end



