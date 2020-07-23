require 'rails_helper'


RSpec.describe Comment, type: :model do
    describe 'validation' do
        before(:each) { 
            @user = FactoryBot.create(:user1)
            @schedule = FactoryBot.create(:schedule)
        }
        it "is not valid without a body" do
            @comment = Comment.new(:body => nil, :user => @user, :schedule => @schedule)
            expect(@comment).to_not be_valid
            @comment.body = "test comment"
            expect(@comment).to be_valid
        end
        it "is not valid with a too short body" do
             @comment = Comment.new(:body => "1234", :user => @user, :schedule => @schedule)
             expect(@comment).to_not be_valid
            @comment.body = "12345"
            expect(@comment).to be_valid
        end

    end
    
    describe "modification" do
        it "is not valid with a too short body" do
            @schedule = FactoryBot.create(:schedule)
            @user = FactoryBot.create(:user1)   
            @comment = Comment.new(:body => "12345", :user => @user, :schedule => @schedule)
             expect(@comment).to be_valid
            @comment.body = "123"
            expect(@comment).to_not be_valid
        end
    end

    #gem shoulda-matchers
    describe "associations" do
        it {should belong_to(:user)}
        it {should belong_to(:schedule)}      
    end
end