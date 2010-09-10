unless DB.table_exists? :posts
  DB.create_table :posts do
    primary_key :id
    varchar :titulo
    varchar :conteudo
  end

  DB[:posts].insert(:titulo => "Primeiro post", :conteudo => "Bla bla bla" )

end

class Post < Sequel::Model
  one_to_many :comments
  many_to_many :tags
end
