require 'rubygems'
require 'sinatra/base'
require 'yaml'

class Blog < Sinatra::Base

  get '/' do
    erb :index
  end

  get '/helper' do
    imprimir("Testando um helper")
  end

  get '/novo_post' do
    erb :novo_post
  end

  post '/novo_post' do
    post = {"Titulo" => params[:titulo], "Conteudo" => params[:conteudo]}
    File.open("posts.yml", "a") do |arquivo|
      arquivo.write(YAML::dump(post))
    end
    redirect '/'
  end
  
  get '/posts' do
    erb :posts
  end

  get '/procurar' do
    erb :procurar
  end

  post '/procurar' do
    @posts = Array.new
    File.open("posts.yml", "r") do |arquivo|
      YAML::load_documents(arquivo) do |doc|
        if doc["Titulo"] =~ /#{params[:busca_titulo]}/i
          @posts.push(doc) 
        end
      end
    end
    erb :posts_encontrados
  end

  helpers do
    def imprimir (mensagem)
      mensagem.upcase!
      "#{mensagem}"
    end
  end

  not_found do
    "Pagina nao encontrada"
  end
end

Blog.run!
