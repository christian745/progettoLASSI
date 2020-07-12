class ProfilesController < ApplicationController
     before_action :authenticate_user!

    def index
        @profiles = User.all  #qui vogliamo che appaia la lista dei profili, devo percio prendere i dati dell'utente nel metodo index cosi da averli disponibili nella view index
    end

    def show
        @profile = User.find(params[:id])  #la show viene chiamata quando sul browser faccio una get ad uno specifico profilo. 
                                           #che è proprio quello che faccio per esempio con la redirect nel metodo create
        @disabled = true
        if (@profile.email == current_user.email)
            @disabled=false
        end

        @count_schedules = Schedule.where(:user_id => @profile.id).length
        @count_tips = Tip.where(:user => @profile.email).length
        @count_comments = Comment.where(:user_id => @profile.id).length
    end

    def destroy
        @profile = User.find(params[:id])   #individuo lo specifico utente che voglio eliminare
        @profile.destroy                        #metodo che elimina l'utente specifico dal database

        redirect_to profiles_path   #ridirigo alla lista dei profili
    end
end
