require 'test_helper'
require './test/booking_contexts'

class BookingTest < ActiveSupport::TestCase
  include Contexts
  #test associations
  
  should belong_to(:room)
  should belong_to(:user)
  
  # test validations
  
  should validate_presence_of(:room_id)
  should validate_presence_of(:user_id)
  should validate_numericality_of(:room_id).only_integer.is_greater_than(0)
  should validate_numericality_of(:user_id).only_integer.is_greater_than(0)
  should validate_presence_of(:start_date)
  should validate_presence_of(:end_date)  
  
  should allow_value(Date.today).for(:start_date)
  should allow_value(1.day.from_now.to_date).for(:start_date)
  should_not allow_value(1.day.ago.to_date).for(:start_date)
  should_not allow_value("bad").for(:start_date)
  should_not allow_value(2).for(:start_date)
  should_not allow_value(3.14159).for(:start_date)
  
  should_not allow_value("bad").for(:end_date)
  should_not allow_value(2).for(:end_date)
  should_not allow_value(3.14159).for(:end_date) 
    
  
  # context
  context "Within context" do
    setup do
      create_bookings
    end

    teardown do
      delete_bookings
    end

    should "shows that there are two bookings in chronological order" do
      assert_equal ["Suite - 100", "Double - 200"], Booking.chronological.all.map{|b| "#{b.room.room_type} - #{b.room.room_number}"}
    end
    
    should "shows that there is 1 upcoming and 1 past booking" do
      @suite_booking.update_attribute(:start_date, 7.days.ago.to_date) # update_attribute will bypass validation
      @suite_booking.update_attribute(:end_date, 2.days.ago.to_date)
      assert_equal 1, Booking.upcoming.size
      assert_equal 1, Booking.past.size
    end    
  end

end
