require('sinatra')
require('sinatra/contrib/all') if development?
require_relative('./models/album')
require_relative('./models/artist')
also_reload('.models/*')

get '/artist' do
  erb(:home)
end

get '/artist/all' do
  @artists = Artist.all
  erb(:index)
end

get '/artist/new_artist' do
  erb(:new_artist)
end

post '/artist' do
  @artist = Artist.new(params)
  @artist.save()
  redirect to '/artist/all'
end

post '/artist/:id/delete' do
  @artist = Artist.find(params[:id])
  @artist.delete()
  redirect to '/artist/all'
end

post '/album/:id/delete' do
  @album = Album.find(params[:id])
  artist_id = @album.artist_id
  @album.delete()
  redirect to "/artist/#{artist_id}"
end

get '/artist/:id' do
  @artist = Artist.find(params[:id])
  @albums = Artist.albums(@artist.id)
  erb(:show)
end
