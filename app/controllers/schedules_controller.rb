class SchedulesController < ApplicationController
    before_action :authenticate_user! , except: [:index, :about, :christian, :sandro, :lorenzo]    #questo metodo impone che un utente per andare oltre la pagina iniziale si debba loggare o registrare. tranne che per la pagina iniziale, quella puo essere vista anche da utenti non registrati
    def index
        @schedules = Schedule.all 
    end

    def show
        @schedule = Schedule.find(params[:id])  #la show viene chiamata quando sul browser faccio una get ad una specifica scheda. 
                                                #che è proprio quello che faccio per esempio con la redirect nel metodo create
    end

    def new
        @schedule = Schedule.new
    end

    def create                                                                  #per ora levo :descrizione dai parametri perche per ora sto provando la get all api e uso il campo descrizione, se funziona la chiamata aggiungo una colonna alle schedule per il body della risposta all api
        @schedule = Schedule.new(params.require(:schedule).permit(:tipo , :muscoli, :descrizione, :titolo)) #in una variabile @schedule metto il risultato di una new chiamata sulla tabella del database schedule
                                                  #alla new ho passato i parametri della form creata nella view new.html.erb (rappresentati dalla variabile :schedule)
       
        search=params[:schedule][:search] #queste tre posso anche dichiararle senza chiocciola in quanto non è necessario passarle alla view
        name=""
        tag=params[:schedule][:tag]  #dalla form_for :schedule definita nella view new prendi il parametro inserito nel campo :tag   fonti: https://stackoverflow.com/questions/11342083/ruby-on-rails-form-and-passing-its-parameter-to-controller

        if(name==nil && tag==nil && search==nil) 
           flash[:alert] = "there must be almost one parameters among tag,name and search" 
           render "new" 
        end

        #usando il metodo HTTParty.get mando una richiesta all'url indicato e salvo la risposta. possiamo fare cio grazie alla gemma httparty che ho installato precedentemente. documentazione: https://github.com/jnunemaker/httparty
        #DOCUMENTAZIONE API USATA: https://www.bulkhackers.com/quotes-api/
        @http = HTTParty.get('https://www.bulkhackers.com/wp-json/bulk-hackers/get-quotes?tag='+tag+'&search='+search+'&name='+name+'&access='+ENV['API_KEY'])

        @length = @http.count #conto le citazioni disponibili per quei parametri selezionati
          
        #la risposta è in formato json, ho dovuto percio installare la gemma 'json' per poter qui gestire la risposta. 
        @cit = @http.dig(rand(@length),'quote')  #prendo una citazione tra quelle che mi ha mandato il server in modo casuale
        @fonte = @http.dig(rand(@length),'name')
        #IMPO: il metodo dig si assicura che, nel caso in cui @http sia nil(cioe se non è disponibile una quote per i parametri selezionati), le operazioni
        #      eseguite su @http, atte ad otenere @response (che dovrebbe essere la sola quote estratta dalla risposta alla chiamata get), non producano
        #      un errore dovuto proprio al fatto di star lavorando su una variabile nil. funzione dig trovata qui: https://rollbar.com/blog/top-10-ruby-on-rails-errors/
 
        #il messaggio della risposta alla get lo salvo nel campo descrizione della nuova schedule che stiamo creando
        
        #riempo il campo quote con la risposta ricevuta dal server ed elaborata sopra
        @schedule.quote=@cit
        @schedule.fonte=@fonte
        
        #il campo user dlla schedaa che sto creando lo riempo con l'id dell utente che la sta creando
        @schedule.user = current_user 


        #prima controllo che la risposta ricevuta dal server non sia vuota. se lo è mostro il relativo messaggio e ricarico la pagina
        if(@cit == nil)   
            flash[:alert] = "there are not available quotes matching with selected parameters. change it and retry" 
            render "new"      
        elsif(@schedule.save)  #poi controllo che la scheda sia salvata correttamente. se è cosi rimando alla pagina con tutte le schede
            redirect_to @schedule
        else
            flash[:alert] = "something gone wrong with saving. have you filled all the areas?"
            render 'new'   #altrimenti ricarica la pagina 
        end
    end

    def edit
        @schedule = Schedule.find(params[:id]) #ci prendiamo la scheda specifica che vogliamo editare, come nella show
    end

    def update
        @schedule = Schedule.find(params[:id]) #recupero lo schedule di cui si parla analogamente a quanto fatto in edit

        if(@schedule.update(params.require(:schedule).permit(:tipo,:muscoli,:descrizione,:search,:name,:tag, :titolo)))           #controllo analogo alla create, dobbiamo pero
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

    def about 
        
    end

    def christian
    end
    def sandro
    end
    def lorenzo
    end


    def filter_schedules
        @user_id = params[:id]
        @schedules = Schedule.where(:user_id => @user_id)
        render "index"
    end
    


    def filter_comments
        @user = params[:id]
        @query = Comment.select("schedule_id").where(:user_id => @user).uniq
        @comments = []
        
        @query.each do |q|
            @comments.push(q.schedule_id)
        end

        @schedules = Schedule.all.select {|schedule| @comments.include? schedule.id}
        render "index"
    end 
end
