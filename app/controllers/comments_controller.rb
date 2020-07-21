class CommentsController < ApplicationController

    def create
        @schedule = Schedule.find(params[:schedule_id])  #trova la scheda che vogliamo commentare
        @comment = @schedule.comments.create(params.require(:comment).permit(:body).merge(user_id: current_user.id)) #permit serve ha dare i permessi ad aggiungere quei valori. devo dare il permesso per body che inserisco nella form del commento e per user_id che mi prendo con l'hidden_field
       
        redirect_to schedule_path(@schedule) #rimanda alla pagina della scheda
    end

    def edit
        @schedule = Schedule.find(params[:schedule_id])
        @comment = Comment.find(params[:id]) 
        if(@comment.user)
            if(@comment.user.id == current_user.id || current_user.admin)
                render 'edit'
            else
                redirect_to schedule_path(@schedule)
            end
        end
    end

    def update
        @schedule = Schedule.find(params[:schedule_id]) #devo salvarmi la scheda da cui viene il commento per poter reindirizzare l'utente una volta finito di modificare il commento
        @comment = Comment.find(params[:id]) #recupero lo schedule di cui si parla analogamente a quanto fatto in edit
        
        if(@comment.user.id == current_user.id || current_user.admin)
            if(@comment.update(params.require(:comment).permit(:body)))#controllo analogo alla create
                redirect_to schedule_path(@schedule)  #rimando alla scheda a cui appartiene il commento
            else 
                render 'edit'  
            end
        else
            redirect_to schedule_path(@schedule)
        end
    end

    def destroy
        @schedule = Schedule.find(params[:schedule_id])   #in _comments.html.erb quando premo il pulsante delete mando a questa funzione 2 parametri, l'id del commento e quello della scheda. li uso per eliminare il commento qui.
        @comment = Comment.find(params[:id])    #individuo il commento da cancellare della scheda corrente
        
        if(@comment.user)
            if(@comment.user.id == current_user.id || current_user.admin)
                @comment.destroy                                    #elimino il commento dal database
                redirect_to schedule_path(@schedule)
            end
        else
            redirect_to schedule_path(@schedule)   #ridirigo alla pagina della scheda a cui apparteneva il commento, devo per forza passargli @schedule altrimenti non capisce a qual scheda andare
        
        end
    end
end