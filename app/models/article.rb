class Article < ApplicationRecord
    belongs_to :user
    has_many :blog_comments, dependent: :destroy
    def self.ransackable_attributes(auth_object = nil)
        ["content", "id", "id_value", "title", "user_id"]
    end
    def self.ransackable_associations(aut_object = nil)
        ["users"]
    end
end
