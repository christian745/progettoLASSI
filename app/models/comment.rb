class Comment < ApplicationRecord
   
   belongs_to :schedule             #significa che ogni commento è relativo a una sola scheda
   belongs_to :user      
  
  
  #metto delle condizioni alla form per aggiungere il commento. come la presenza obbligatoria, o la lunghezza minima
  validates :body, presence: true, length: {minimum: 5}
              
end
