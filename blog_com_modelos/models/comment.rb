unless DB.table_exists? :comments
  DB.create_table :comments do
    primary_key :id
    foreign_key :post_id, :posts
    varchar :body
  end

  DB[:comments].insert(:post_id => 1, :body => "Bla bla bla")
end

class Comment < Sequel::Model
  many_to_one :posts
end
