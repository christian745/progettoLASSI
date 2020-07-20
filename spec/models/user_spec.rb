require 'rails_helper'


RSpec.describe User, type: :model do
    describe 'validations' do 
        
        it "is not valid without a name" do
            @user = User.new(:surname => "cognome", :email => "example@example.com", :password => "password")
            expect(@user).to_not be_valid
            @user.name = "name"
            expect(@user).to be_valid           
        end

        it "is not valid without a surname" do
            @user = User.new(:name => "nome", :email => "example@example.com", :password => "password")
            expect(@user).to_not be_valid
            @user.surname = "surname"
            expect(@user).to be_valid         
        end
    
        it "is not valid without a email" do
            @user = User.new(:name => "nome", :surname => "cognome", :password => "password")
            expect(@user).to_not be_valid         
            @user.email = "email@email.it"
            expect(@user).to be_valid    
        end

        it "is not valid without a password" do
            @user = User.new(:name => "nome", :surname => "cognome", :email => "example@example.com")
            expect(@user).to_not be_valid@user.name = "name"
            @user.password = "password"
            expect(@user).to be_valid 
            
            
        end
    end
end
