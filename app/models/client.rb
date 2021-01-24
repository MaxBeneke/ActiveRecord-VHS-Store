class Client < ActiveRecord::Base
has_many :rentals
has_many :vhs, through: :rentals

def self.paid_most
high_roller = ""
highest_price = 0

Client.all.each{|client|
 price_paid = (client.rentals.count * 5.35) + (client.late_rentals.count * 12.00)
    if price_paid > highest_price
        high_roller = client
        highest_price = price_paid
    end
    }
    high_roller
end



def rental_fees
    self.rentals.count * 5.35
end

def late_rentals
    late_rentals_array = []   
 already_returned = Rental.all.select{|rental|rental.current == false}

already_returned.each{|rental|
if rental.updated_at - 7.days > rental.created_at 
    late_rentals_array << rental
end
}
late_rentals_array
end


def self.first_rental(name, home_address, vhs)
  person =  Client.create(name: name,home_address: home_address)
#   open_rental = Rental.find_by(current: false)
  Rental.create(current: true, vhs_id: vhs.id, client_id: person.id)
end

def return_one(vhs)
        self.rentals.find{|rental|rental.vhs == vhs}.update(current: false)

end

def last_return
   self.rentals.each{|rental| rental.current = false}
   self.destroy
end




end
