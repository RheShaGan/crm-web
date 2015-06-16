class Contact
  attr_accessor :first_name, :last_name, :email, :notes
  attr_reader :id

  def initialize(id, first_name, last_name, email, notes)
    @id = id
    @first_name = first_name
    @last_name = last_name
    @email = email
    @notes = notes
  end

def to_s
  "#{@id}--#{@first_name} #{@last_name} --#{@email}--#{@notes}"
  
end
end