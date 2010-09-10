unless DB.table_exists? :tags
  DB.create_table :tags do
    primary_key :id
    varchar :nome
  end
end

unless DB.table_exists? :posts_tags
  DB.create_table :posts_tags do
    foreign_key :tag_id, :tags
    foreign_key :post_id, :posts
  end
end

class Tag < Sequel::Model
  many_to_many :posts
end
