require "rails_helper"

RSpec.describe ProfilesController, :type => :controller do 
    describe "Profiles management" do
        before(:each) do
            @request.env["devise.mapping"] = Devise.mappings[:user]
            @user = FactoryBot.create(:user1)
            sign_in @user
        end

        it "GET profiles#index -> should lists emails of all users" do 
            get :index
            expect(response).to render_template(:index)
        end
        
        it "GET profiles#show -> should shows the details of the selected profile" do
            get :show, params: { id: @user.id }
            expect(response).to render_template(:show)
        end
        
        context "DELETE profiles#destroy ->" do
            context "as a user" do
                context 'owner of selected profile' do
                    it "should remove my profile from the list" do
                        expect{
                            delete :destroy, params: { id: @user.id }
                        }.to change(User, :count).by(-1)
                    end
                end
                
                context 'different from the selected profile' do
                    it "should not remove selected profile from the list" do
                        @user2 = FactoryBot.create(:user2)
                        expect{
                            delete :destroy, params: { id: @user2.id }
                        }.to change(User, :count).by(0)
                    end
                end
            end

            #[test rappresentativo della user story da testare]
            context "as an admin" do
                it "should remove selected profile from the list" do
                    @admin = FactoryBot.create(:admin)
                    sign_in @admin
                    @user = FactoryBot.create(:user2)
                    expect{
                            delete :destroy, params: { id: @user.id }
                        }.to change(User, :count).by(-1)
                end
            end
        end
    end
end