require 'test_helper'
require './test/user_contexts'

class UserTest < ActiveSupport::TestCase
  include Contexts
  should have_secure_password

  #test associations
  
  should have_many(:bookings)
  should have_many(:rooms).through(:bookings)
  # test validations
  
  should validate_presence_of(:username)

  should allow_value("fred@fred.com").for(:email)
  should allow_value("fred@andrew.cmu.edu").for(:email)
  should allow_value("my_fred@fred.org").for(:email)
  should allow_value("fred123@fred.gov").for(:email)
  should allow_value("my.fred@fred.net").for(:email)
  
  should_not allow_value("fred").for(:email)
  should_not allow_value("fred@fred,com").for(:email)
  should_not allow_value("fred@fred.uk").for(:email)
  should_not allow_value("my fred@fred.com").for(:email)
  should_not allow_value("fred@fred.con").for(:email)
  should_not allow_value(nil).for(:email)
  
  should allow_value("4122683259").for(:phone)
  should allow_value("412-268-3259").for(:phone)
  should allow_value("412.268.3259").for(:phone)
  should allow_value("(412) 268-3259").for(:phone)
  
  should_not allow_value("2683259").for(:phone)
  should_not allow_value("4122683259x224").for(:phone)
  should_not allow_value("800-EAT-FOOD").for(:phone)
  should_not allow_value("412/268/3259").for(:phone)
  should_not allow_value("412-2683-259").for(:phone)
  should_not allow_value(nil).for(:phone)
  
  
  # context
  context "Within context" do
    setup do
      create_users
    end

    teardown do
      delete_users
    end

    should "require users to have unique, case-insensitive usernames" do
      assert_equal "dphelps", @mark_user.username
      # try to switch to Alex's username 'tank'
      @mark_user.username = "TANK"
      assert_not @mark_user.valid?
    end

    should "allow user to authenticate with password" do
      assert @mark_user.authenticate("foobar")
      assert_not @mark_user.authenticate("notsecret"), true
    end

    should "require a password for new users" do
      bad_user = FactoryBot.build(:user, username: "tank", password: nil)
      assert_not bad_user.valid?
    end

    should "require passwords to be confirmed and matching" do
      bad_user_1 = FactoryBot.build(:user, username: "tank", password: "secret", password_confirmation: nil)
      assert_not bad_user_1.valid?
      bad_user_2 = FactoryBot.build(:user, username: "tank", password: "secret", password_confirmation: "sauce")
      assert_not bad_user_2.valid?
    end

    should "require passwords to be at least six characters" do
      bad_user = FactoryBot.build(:user, username: "tank", password: "no")
      assert_not bad_user.valid?
    end

    should "strip non-digits from the phone number" do
      assert_equal "4123694314", @alex_user.phone
    end
    
    should "show three names in alphabetical order" do
      assert_equal ["Phelps, Daniel", "Phelps, Joey", "Smith, Daniel"], User.alphabetical.all.map{|u| "#{u.last_name}, #{u.first_name}"}
    end
  end

end
