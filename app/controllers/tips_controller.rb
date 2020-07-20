class TipsController < ApplicationController
    before_action :authenticate_user!    #questo metodo impone che un utente per andare oltre la pagina iniziale si debba loggare o registrare. tranne che per la pagina iniziale, quella puo essere vista anche da utenti non registrati
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
            @tip=Tip.create!({user: user.email, titolo: tit, categoria: cat, contenuto: cont })
            redirect_to tips_path
        end
    end

    def show
        @tip = Tip.find(params[:id])
        @user=current_user.email
        @tip_user=@tip.user
        @disabled=true
        if (@user == @tip_user || current_user.admin)
            @disabled=false
        end
        
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
        @tip = Tip.find(id)
        query= Tip.where(titolo: tit)
        if (query.length != 0)
            flash[:alert] = "Titolo già esistente"
            redirect_to edit_tip_path(@tip)
            return
        end
        if (@tip.titolo != tit || @tip.categoria != cat || @tip.contenuto != cont)
            @tip.update!(titolo: tit, categoria: cat, contenuto: cont)
        end
        redirect_to tip_path(@tip)
    end

    def destroy
        @user=current_user.email
        tip=Tip.find(params[:id])
        @tip_user=tip.user
        if (@user == @tip_user || current_user.admin)
            tip.destroy
            redirect_to tips_path
        end
    end

    def filter
        user_id = params[:id]
        user = User.find(user_id).email
        @tips = Tip.where(:user => user)
        render "tips/index"
    end
    
end
