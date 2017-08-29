require('sinatra')
require('sinatra/contrib/all') if development?
require_relative('../models/album')
require_relative('../models/artist')
require('pry')
also_reload('.models/*')

get '/album/new' do
  @artists = Artist.all
  erb(:'album/new_album')
end

post '/album' do
  @albums = Album.new(params)
  @albums.save()
  redirect to '/artist/all'
end

post '/album/artist_search' do
 found = Album.find_by_title(params["title"])
  if found == []
    erb(:'album/no_match')
  else
    redirect to "/artist/#{found.artist_id}"
  end
end

#genre-start
get '/album/all_genres' do
  @albums = Album.all
  erb(:'album/all_genres')
end

post '/album/:id/delete' do
  @album = Album.find(params[:id])
  artist_id = @album.artist_id
  @album.delete()
  redirect to "/artist/#{artist_id}"
end

get '/album/:id/edit' do
  @artists = Artist.all
  @album = Album.find(params[:id])
  erb(:'album/edit_album')
end

post '/album/:id' do
  @album = Album.new(params)
  artist_id = @album.artist_id
  @album.update()
  erb(:'artist/update')
end
