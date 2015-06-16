require_relative('contact.rb')


class Rolodex
  @@id = 1

  def initialize
    @contacts = []

    add_contact("Jane", "Doe", "jd@unknown.com", "missing")
    add_contact("John", "Doe", "johnd@unknown.com", "found")
    add_contact("Mary Jane","Watson", "spidermanfan@gmail.com", "needs rescuing" )
    add_contact("Amelia", "Airheart", "firstwoman@aroundtheworld.com", "missing")
    add_contact("Franz", "Ferdinand", "cause@wwone.com", "missing")

  end

  def add_contact(first_name, last_name, email, notes)
    contact = Contact.new(@@id, first_name, last_name, email, notes)
    @@id += 1

    @contacts << contact
  end

  def modify_contact(id, to_edit, edit_info)

    contact_edit = search_contact(id)
    
    case to_edit
    when "First name"
      contact_edit.first_name = edit_info.capitalize
      puts "#{contact_edit.first_name}"
    when "Last name"
      contact_edit.last_name = edit_info.capitalize
      puts "#{contact_edit.last_name}"
    when "Email"
      contact_edit.email = edit_info
      puts "#{contact_edit.email}"
    when "Notes"
      contact_edit.notes = edit_info
      puts "#{contact_edit.notes}"
    end
    
  end

  def display_all_contacts
    @contacts
  end

  def display_particular_contact(contact_input)
    c = search_contact(contact_input)

    puts c

  end

  def display_info_by_attribute(attribute)

    case attribute
    when "First name"
      @contacts.each {|contact|
        puts "#{contact.id} #{contact.first_name}"}
    when "Last name"
      @contacts.each {|contact|
        puts "#{contact.id} #{contact.last_name}"}
    when "Email"
      @contacts.each {|contact|
        puts "#{contact.id} #{contact.email}"}
    when "Notes"
      @contacts.each {|contact|
        puts "#{contact.id} #{contact.notes}"}
    end

    
  end

  def search_contact(id)
   c = @contacts.find do |contact|
      id == contact.id
    end

    return c

  end


  def delete_contact(delete_id)
    remove = search_contact(delete_id)

    @contacts.delete(remove)

    puts "Contact has been deleted successfully."


    
  end

end