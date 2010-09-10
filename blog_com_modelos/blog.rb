require 'rubygems'
require 'sinatra'
require 'sequel'

DB = Sequel.sqlite('./db/blog.db')

require 'models/tag'
require 'models/post'
require 'models/comment'

class Blog < Sinatra::Base
  get '/' do
    erb :lista
  end

  get '/posts/:id' do
    @post = Post[params[:id]]
    erb :show
  end

  post '/posts' do
    post = Post.new
    post.titulo = params[:titulo]
    post.conteudo = params[:conteudo]
    post.save
    
    tags = params[:tags].split
    tags.each do |tag|
      adicionou = false
      Tag.all.each do |tag_existente|
        if tag == tag_existente.nome
          post.add_tag(tag_existente)    
          adicionou = true
          break
        end
      end

      unless adicionou
        post.add_tag(:nome => tag)
      end
    end
    redirect '/'
  end

  get '/posts/:id/edit' do
    @post = Post[params[:id]]
    erb :edit
  end

  post '/posts/:id' do
    post = Post[params[:id]]

    post.titulo = params[:post][:titulo]
    post.conteudo = params[:post][:conteudo]
    post.save

    redirect '/'
  end

  get '/posts/:id/delete' do
    post = Post[params[:id]]
    post.remove_all_comments
    post.remove_all_tags
    post.destroy
    
    redirect '/'
  end

  post '/posts/:id/comments' do
    post = Post[params[:id]]
    post.add_comment(:body => params[:comment][:body])

    redirect "/posts/#{params[:id]}"
  end

  get '/tags/:id' do
    @tag = Tag[params[:id]]
    erb :tags
  end

end

Blog.run!
