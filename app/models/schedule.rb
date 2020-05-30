class Schedule < ApplicationRecord
    has_many :comments,dependent: :delete_all                #dopo aver creato la tabella per i commenti nel database, con il riferimento alla tabella schedule, bisogna aggiungere anche questa relazione 
    belongs_to :user                                         #appartiene a un solo user, riferimento analogo nel controllore degli user
    
    validates :tipo, presence: true   #metto delle condizioni alla form per aggiungere schede. come la presenza obbligatoria, o la lunghezza minima
    validates :muscoli, presence: true


    #IMPORTANTE: dato che una scheda è legata a piu commenti, devo usare l'opzione on delete cascade sule schede cosi che se
    #            volessi eliminare una scheda non riscontrerei problemi nel farlo neanche nel caso avesse ancora dei commenti, cioe delle diendenze.
    #            per fare cio ho aggiunto dependent: :delete_all nel riferimento ai commenti per la scheda in questo modulo
end
