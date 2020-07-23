class Tip < ApplicationRecord
    belongs_to :user
    validates_presence_of :titolo, :categoria, :contenuto 
end
