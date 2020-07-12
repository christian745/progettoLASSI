class MyregistrationsController < Devise::RegistrationsController

  def update 
    @profile = User.find(resource.id)
    if ( params[:user][:name] == "" || params[:user][:surname] == "" || params[:user][:gender] == "")
      flash[:alert] = "I campi nome e cognome sono obbligatori"
      redirect_to edit_user_registration_path(@profile)
      return
    end
    @profile.update!(name: params[:user][:name],surname: params[:user][:surname],address: params[:user][:address],gender: params[:user][:gender])
    redirect_to profile_path(@profile)
  end
  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

end
