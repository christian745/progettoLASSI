class User < ApplicationRecord
  validates :email, uniqueness: true #cosi da rendere la mail per forza unica

  has_many :schedules  #prima avevo creato le schedules, poi ho creato gli users con device, poi ho aggiunto alle schedules il riferimento allo user_id.
                       #qui devo quindi aggiungere la cardinalita della relazione tra user e schedules
  has_many :comments
  has_many :tips


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2] 

  validates_presence_of :name, :surname, :email, :password, :on => :create

  validates_presence_of :name, :surname, :on => :update
  

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.first_name
      user.surname = auth.info.last_name
    end
  end
end
