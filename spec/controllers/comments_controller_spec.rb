require "rails_helper"

RSpec.describe CommentsController, :type => :controller do 
    describe "Comment management" do
        before(:each) do
            @request.env["devise.mapping"] = Devise.mappings[:user]
            @user = FactoryBot.create(:user1)
            sign_in @user
        end

        it "GET comments#create -> should creates a new comment" do 
            @schedule = FactoryBot.create(:schedule)
            expect {
                post :create, params: {schedule_id: @schedule.id, comment: {body: "prova"} }
                }.to change(Comment.where(schedule_id: @schedule.id), :count).by(1) 
        end

        context 'GET comments#edit ->' do
            context 'as a owner of selected comment' do
                it "should shows the details of the selected comment" do
                    @comment = FactoryBot.create(:comment)
                    sign_in @comment.user
                    get :edit, params: { schedule_id: @comment.schedule.id, id: @comment.id }
                    expect(response).to render_template(:edit)
                end
            end

            context 'as not a owner of selected comment' do
                it "should not shows the details of the selected comment" do
                    @comment = FactoryBot.create(:comment)
                    sign_in @user
                    get :edit, params: { schedule_id: @comment.schedule.id, id: @comment.id }
                    expect(response).to_not render_template(:edit)
                end
            end

            context 'as an admin' do
                it "should shows the details of the selected comment" do
                    @comment = FactoryBot.create(:comment)
                    @admin = FactoryBot.create(:admin)
                    sign_in @admin
                    get :edit, params: { schedule_id: @comment.schedule.id, id: @comment.id }
                    expect(response).to render_template(:edit)
                end
            end
        end

        context 'PUT comments#update ->' do
            context 'as a owner of selected comment' do
                it "should modify the selected comment" do
                    @comment = FactoryBot.create(:comment)
                    sign_in @comment.user
                    put :update, params: { schedule_id: @comment.schedule.id, id: @comment.id, comment: {body: "prova"}}
                    expect(response).to redirect_to(schedule_path(@comment.schedule.id))
                end
            end

            context 'as not a owner of selected comment' do
                it "should not modify the selected comment" do
                    @comment = FactoryBot.create(:comment)
                    sign_in @user
                    put :update, params: { schedule_id: @comment.schedule.id, id: @comment.id, comment: {body: "prova"}}
                    expect(response).to_not render_template(:edit)
                end
            end

            context 'as an admin' do
                it "should modify the selected comment" do
                    @comment = FactoryBot.create(:comment)
                    @admin = FactoryBot.create(:admin)
                    sign_in @admin
                    put :update, params: { schedule_id: @comment.schedule.id, id: @comment.id, comment: {body: "prova"}}
                    expect(response).to redirect_to(schedule_path(@comment.schedule.id))
                end
            end
        end


        context 'DELETE comments#destroy ->' do
            context 'as a owner of selected comment' do
                it "should delete the selected comment" do
                    @comment = FactoryBot.create(:comment)
                    sign_in @comment.user
                    expect{
                        delete :destroy, params: { schedule_id: @comment.schedule.id, id: @comment.id}
                    }.to change(Comment.where(schedule_id: @comment.schedule.id), :count).by(-1) 
                end
            end

            context 'as not a owner of selected comment' do
                it "should not delete the selected comment" do
                    @comment = FactoryBot.create(:comment)
                    sign_in @user
                    expect{
                        delete :destroy, params: { schedule_id: @comment.schedule.id, id: @comment.id}
                    }.to change(Comment.where(schedule_id: @comment.schedule.id), :count).by(0) 
                end
            end

            context 'as an admin' do
                it "should delete the selected comment" do
                    @comment = FactoryBot.create(:comment)
                    @admin = FactoryBot.create(:admin)
                    sign_in @admin
                    expect{
                        delete :destroy, params: { schedule_id: @comment.schedule.id, id: @comment.id}
                    }.to change(Comment.where(schedule_id: @comment.schedule.id), :count).by(-1) 
                end
            end
        end

    end
end