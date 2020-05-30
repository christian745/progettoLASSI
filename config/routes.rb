Rails.application.routes.draw do

  root to: "schedules#index"  #cosi la root del progetto sara direttamente la pagina conl'elenco di schede (dalle routes)
 
  devise_for :users #automaticamente apparso quando abbiamo installato devise ed eseguito la migrate
 
  resources :schedules do
    resources :comments    # in questo modo ogni schedule avra la sua serie di commenti
  end

end


 # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
