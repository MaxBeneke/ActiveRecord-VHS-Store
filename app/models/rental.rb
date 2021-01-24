class Rental < ActiveRecord::Base
belongs_to :vhs
belongs_to :client

def due_date

created_at + 7.days

end

def self.past_due_date

 late_rentals = []   
 already_returned = Rental.all.select{|rental|rental.current == false}

already_returned.each{|rental|
if rental.updated_at - 7.days > rental.created_at 
    late_rentals << rental
end
}

unreturned = Rental.all.select{|rental|rental.current == true}
unreturned.each{|rental|
if DateTime.now - 7.days > rental.created_at 
    late_rentals << rental
end
}
late_rentals
end

def self.returned?
    self.all.select{|rental| rental.current == false}

end


end