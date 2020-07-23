class ProfilesController < ApplicationController
    before_action :authenticate_user!
    before_action :verify_authenticity_token

    def index
        @profiles = User.all  #qui vogliamo che appaia la lista dei profili, devo percio prendere i dati dell'utente nel metodo index cosi da averli disponibili nella view index
    end

    def show
        @profile = User.find(params[:id])  #la show viene chiamata quando sul browser faccio una get ad uno specifico profilo. 
                                           #che è proprio quello che faccio per esempio con la redirect nel metodo create                      
        @disabled = true
        if (@profile.email == current_user.email || current_user.admin)
            @disabled=false
        end

        @count_schedules = Schedule.where(:user_id => @profile.id).length
        @count_tips = Tip.where(:user => @profile).length
        @count_comments = Comment.where(:user_id => @profile.id).length
    end

    def edit
        @profile = User.find(params[:id])
    end

    def update 
        @profile = User.find(params[:id])
        if ( params[:name] == "" || params[:surname] == "" || params[:gender] == "")
            flash[:alert] = "I campi nome e cognome sono obbligatori"
            redirect_to edit_profile_path(@profile)
            return
        end
        @profile.update!(name: params[:name],surname: params[:surname],address: params[:address],gender: params[:gender])
        redirect_to profile_path(@profile)
    end

    def destroy
        @profile = User.find(params[:id])       #individuo lo specifico utente che voglio eliminare
        if(current_user.admin || current_user.id == @profile.id)
            @profile.destroy                        #metodo che elimina l'utente specifico dal database
            redirect_to profiles_path   #ridirigo alla lista dei profili
        else
            redirect_to profile_path(@profile)
        end
    end
end
