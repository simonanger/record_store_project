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

get '/artist/new' do
  erb(:new_artist)
end

post '/artist' do
  @artist = Artist.new(params)
  @artist.save()
  redirect to '/artist/all'
end

get '/album/new' do
  @artists = Artist.all
  erb(:new_album)
end

post '/album' do
  @albums = Album.new(params)
  @albums.save()
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

get '/artist/:id/edit' do
  @artist = Artist.find(params[:id])
  erb(:edit_artist)
end

post '/artist/:id' do
  @artist = Artist.new(params)
  @artist.update()
  redirect to "/artist/all"
end

get '/album/:id/edit' do
  @album = Album.find(params[:id])
  erb(:edit_album)
end

post '/album/:id' do
  @album = Album.new(params)
  artist_id = @album.artist_id
  @album.update()
  redirect to "/artist/#{artist_id}"
end
