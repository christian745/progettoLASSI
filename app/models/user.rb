class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :email, uniqueness: true #cosi da rendere la mail per forza unica

 
  
  has_many :schedules  #prima avevo creato le schedules, poi ho creato gli users con device, poi ho aggiunto alle schedules il riferimento allo user_id.
                       #qui devo quindi aggiungere la cardinalita della relazione tra user e schedules
  has_many :comments


end
