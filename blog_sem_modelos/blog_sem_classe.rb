require 'rubygems'
require 'sinatra'

get '/' do
  erb :index
end

get '/novo_post' do
end

post '/novo_post' do
end

get '/posts' do
end

get '/procurar' do
end


__END__

@@ index
<h1> Titulo do blog <h1>
