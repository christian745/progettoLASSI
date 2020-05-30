class SchedulesController < ApplicationController
    before_action :authenticate_user! , except: [:index]    #questo metodo impone che un utente per andare oltre la pagina iniziale si debba loggare o registrare. tranne che per la pagina iniziale, quella puo essere vista anche da utenti non registrati
    def index
        @schedules = Schedule.all  #qui vogliamo che appaia la lista di tutte le schede
    end

    def show
        @schedule = Schedule.find(params[:id])  #la show viene chiamata quando sul browser faccio una get ad una specifica scheda. 
                                                #che è proprio quello che faccio per esempio con la redirect nel metodo create
    end

    def new
        @schedule = Schedule.new   #passiamo al metodo new la variabile @schedule cosi da averla disponibile nella view new. ci servira per visualizzare eventuali messaggi di errore
    end

    def create
        @schedule = Schedule.new(params.require(:schedule).permit(:tipo , :muscoli, :descrizione)) #in una variabile @schedule metto il risultato di una new chiamata sulla tabella del database schedule
                                                  #alla new ho passato i parametri della form creata nella view new.html.erb (rappresentati dalla variabile :schedule)
    
        @schedule.user = current_user 
        if(@schedule.save)   #salvo le modifiche al database. controllo inoltre se le condizioni specificate nel modulo schedule per la creazione di un nuovo elemento sono state rispettate
            redirect_to @schedule  #se è cosi redirigo il browser verso l'elemento appena inserito
        else 
            render 'new'   #ricarica la pagina altrimenti
        end
    
    
    end

    def edit
        @schedule = Schedule.find(params[:id]) #ci prendiamo la scheda specifica che vogliamo editare, come nella show
    end

    def update
        @schedule = Schedule.find(params[:id]) #recupero lo schedule di cui si parla analogamente a quanto fatto in edit

        if(@schedule.update(params.require(:schedule).permit(:tipo , :muscoli, :descrizione)))           #controllo analogo alla create, dobbiamo pero
            redirect_to @schedule 
        else 
            render 'edit'  
        end
    end

    #avevo pensato di implementare qui(nella destroy) il blocco al pulsante delete per le schede, mostrando un messaggio di warning se chi voleva eliminare la scheda non era chi l'aveva creata, e ovviamente impedendo la cancellazione.
    #pero,anche se funzionava tutto, non riuscivo a dare uno stile che mi piacesse al messaggio. Percio implemento questa funzionalita della show: il bottone delete è bloccato se non hai creato tu la scheda.

    def destroy
        @schedule = Schedule.find(params[:id])   #sempre per individuare la specifica scheda di cui si parla
        @schedule.destroy                        #metodo che elimina la scheda dal database

        redirect_to schedules_path   #ridirigo alla home con la lista delle schede 
    end
end
