module Contexts
  def create_bookings
    @suite = FactoryBot.create(:room)
    @double = FactoryBot.create(:room, room_number: 200, room_type: "Double")
    @single = FactoryBot.create(:room, room_number: 300, room_type: "Single")

    @dphelps = FactoryBot.create(:user)
    @gphelps = FactoryBot.create(:user, username: "gphelps")

    @suite_booking = @dphelps.bookings.create(start_date: Date.today, end_date: 5.days.from_now.to_date, room: @suite)
    @double_booking = @gphelps.bookings.create(start_date: 4.days.from_now.to_date, end_date: 9.days.from_now.to_date, room: @double)    
  end
  
  def delete_bookings
    @suite.delete
    @double.delete
    @suite_booking.delete
    @double_booking.delete
    @dphelps.delete
    @gphelps.delete     
  end
  
end
  
  