class CreateBlogComments < ActiveRecord::Migration[8.0]
    def change
        create_table :blog_comments do |t|
            t.text :content
            t.references :user, null: false, foreign_key: true
            t.references :article
            t.timestamps
        end
        # t.add_reference :users, presence: true
        #    t.add_reference :articles
    end
end
