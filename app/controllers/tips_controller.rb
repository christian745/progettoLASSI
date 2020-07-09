class TipsController < ApplicationController
    before_action :authenticate_user! , except: [:index]    #questo metodo impone che un utente per andare oltre la pagina iniziale si debba loggare o registrare. tranne che per la pagina iniziale, quella puo essere vista anche da utenti non registrati
    skip_before_action :verify_authenticity_token  
    def index
        @tips=Tip.all
    end

    def new
               
    end

    def create
        user=current_user
        tit=params[:titolo]
        cat=params[:categoria]
        cont=params[:contenuto]
        trovato=Tip.where(titolo: tit)
        if (trovato.length != 0)
            flash[:alert] = "Titolo già esistente"
            redirect_to new_tip_path
        elsif (tit == "" || cat=="" || cont=="")
            flash[:alert] = "Riempi tutti i campi"
            redirect_to new_tip_path
        else
            @tip=Tip.create!({user: user, titolo: tit, categoria: cat, contenuto: cont })
            redirect_to tips_path
        end
    end

    def show
        @tip = Tip.find(params[:id])
    end

    def edit
        id = params[:id]
        @tip = Tip.find(id)
    end
    
    def update
        id = params[:id]
        tit = params[:titolo]
        cat = params[:categoria]
        cont = params[:contenuto]

    end


    
end
