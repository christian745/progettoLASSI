class User < ApplicationRecord
  validates :email, uniqueness: true #cosi da rendere la mail per forza unica

  has_many :schedules  #prima avevo creato le schedules, poi ho creato gli users con device, poi ho aggiunto alle schedules il riferimento allo user_id.
                       #qui devo quindi aggiungere la cardinalita della relazione tra user e schedules
  has_many :comments


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2] 
  
  

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
end
  
  


  #def self.from_omniauth(auth)
   # where(email: auth.info.email).first_or_initialize do |user|
     # user.email = auth.info.email
     # user.password = SecureRandom.hex
    #end
  #end
=begin
  def self.from_omniauth(auth)
         where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
                 user.email = auth.info.email 
                 user.password = Devise.friendly_token[0,20]
         end 
  end 
=end
  #seconda parte del prof che probabilmente serve per facebooke non so che metterci per google nel dubbio la levo eo vediamo che succede

  #def self.new_with_session(params, session)
  #       super.tap do |user|
  #               if data = session["devise.facebook_data"] && session["devise.facebook_data"] ["extra"]["raw_info"]
  #                        user.email = data["email"] if user.email.blank?     
  #                end 
  #        end  
  #end




end #fine class
