require 'rails_helper'


RSpec.describe User, type: :model do
    describe 'validation' do 

        it "is valid with valid attributes" do
            @user = User.new(:name => "nome", :surname => "cognome", :email => "example@example.com", :password => "password")
            expect(@user).to be_valid
        end

        it "is not valid without a name" do
            @user = User.new(:surname => "cognome", :email => "example@example.com", :password => "password")
            expect(@user).to_not be_valid
            #@user.name = "name"
            #expect(@user).to be_valid           
        end

        it "is not valid without a surname" do
            @user = User.new(:name => "nome", :email => "example@example.com", :password => "password")
            expect(@user).to_not be_valid
            #@user.surname = "surname"
            #expect(@user).to be_valid         
        end
    
        it "is not valid without a email" do
            @user = User.new(:name => "nome", :surname => "cognome", :password => "password")
            expect(@user).to_not be_valid         
            #@user.email = "email@email.it"
            #expect(@user).to be_valid    
        end

        it "is not valid without a password" do
            @user = User.new(:name => "nome", :surname => "cognome", :email => "example@example.com")
            expect(@user).to_not be_valid
            #@user.password = "password"
            #expect(@user).to be_valid 
        end

        it "is valid with an unregistered email" do
            @user1 = User.create!(:name => "nome1", :surname => "cognome1", :email => "example1@example.com", :password => "password")
            @user2 = User.new(:name => "nome2", :surname => "cognome2", :email => "example1@example.com", :password => "password")
            expect(@user2).to_not be_valid
            #@user2.email = "example2@example.com"
            #expect(@user2).to be_valid
            @user1.destroy
        end

    end

    describe 'modification' do
        it "is not valid with a blank name" do
            @user = User.new(:name => "nome1", :surname => "cognome", :email => "example@example.com", :password => "password")
            expect(@user).to be_valid
            @user.name = ""
            expect(@user).to_not be_valid
            #@user.name = "nome2"
            #expect(@user).to be_valid    
        end

        it "is not valid with a blank surname" do
            @user = User.new(:name => "nome", :surname => "cognome1", :email => "example@example.com", :password => "password")
            expect(@user).to be_valid
            @user.surname = ""
            expect(@user).to_not be_valid
            #@user.surname = "cognome2"
            #expect(@user).to be_valid    
        end
    end

    describe 'associations' do
        it { should have_many(:comments) }  
        it { should have_many(:schedules) }
    end


end
