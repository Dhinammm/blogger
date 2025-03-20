class BlogComment < ApplicationRecord
    belongs_to :user
    belongs_to :article
    def self.ransackable_attributes(auth_object = nil)
        ["id", "id_value", "article_id", "content", "user_id"]
    end
    
    def self.ransackable_associations(auth_object = nil)
        ["article", "user"]
    end
end
