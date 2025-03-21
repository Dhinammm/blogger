class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

    def self.ransackable_attributes(auth_object = nil)
        ["name", "email", "id_value", "id"]
    end
    validates :name, presence: true
    def self.from_omniauth(auth)
        where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
            user.email = auth.info.email
            user.password = Devise.friendly_token[0,20]
            user.name = auth.info.name
          user.uid = auth.uid
          user.provider = auth.provider
          user.save!
          user
        end
    rescue => e
        Rails.logger.error "OmniAuth Error: #{e.message}"
    end
   
end
