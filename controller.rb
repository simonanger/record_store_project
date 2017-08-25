require('sinatra')
require('sinatra/contrib/all') if development?
require_relative('./models/album')
require_relative('./models/artist')
also_reload('.models/*')

get '/records' do
  erb(:home)
end

get '/records/all' do
  @artists = Artist.all
  erb(:index)
end

get '/records/new' do
  erb(:new)
end

post '/records' do
  @artist = Artist.new(params)
  @artist.save()
  redirect to '/records/all'
end

get '/records/:id' do
  @artist = Artist.find(params[:id])
  @albums = Artist.albums(@artist.id)
  erb(:show)
end
