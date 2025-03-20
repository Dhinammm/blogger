class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
    has_many :articles, dependent: :destroy
    has_many :blog_comments, dependent: :destroy
    def self.ransackable_attributes(auth_object = nil)
        ["name", "id", "id_value", "email", "password"]
    end

    def self.ransackable_associations(auth_object = nil)
        ["articles"]
    end
    validates :name, presence: true
end
