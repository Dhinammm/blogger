class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
    has_many :articles, dependent: :destroy
    def self.ransackable_attributes(auth_object = nil)
        ["name", "id", "id_value", "email", "encrypted_password", "reset_password_token", "reset_password_sent_at", "remember_created_at"]
    end

    def self.ransackable_associations(auth_object = nil)
        ["articles"]
    end
end
