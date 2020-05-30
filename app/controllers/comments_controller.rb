class CommentsController < ApplicationController

    def create
        @schedule = Schedule.find(params[:schedule_id])  #trova la scheda che vogliamo commentare
        @comment = @schedule.comments.create(params.require(:comment).permit(:body,:user_id)) #permit serve ha dare i permessi ad aggiungere quei valori. devo dare il permesso per bdy che inserisco nella form del commento e per user_id che mi prendo con l'hidden_field
       
        redirect_to schedule_path(@schedule) #rimanda alla pagina della scheda
    end

   
    def destroy
        @schedule = Schedule.find(params[:schedule_id])   #in _comments.html.erb quando premo il pulsante delete mando a questa funzione 2 parametri, l'id del commento e quello della scheda. li uso per eliminare il commento qui.
        @comment = Comment.find(params[:id])    #individuo il commento da cancellare della scheda corrente
        @comment.destroy                                    #elimino il commento dal database
    
        redirect_to schedule_path(@schedule)   #ridirigo alla pagina della scheda a cui apparteneva il commento, devo per forza passargli @schedule altrimenti non capisce a qual scheda andare
    end
end
