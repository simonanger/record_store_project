require('sinatra')
require('sinatra/contrib/all') if development?
require_relative('./models/album')
require_relative('./models/artist')
require('pry')
also_reload('.models/*')

get '/artist' do
  erb(:home)
end

get '/artist/all' do
  @artists = Artist.sort_by_name
  erb(:index)
end

get '/artist/inventory' do
  @albums = Album.all
  erb(:inventory)
end
#sort by album using sort by
post '/artist/inventory' do
  all_album_ids = params["sold"].keys
  sold_album_ids = all_album_ids.select { |album_id| params["sold"][album_id] != "" }

  for sold_album_id in sold_album_ids
    album = Album.find(sold_album_id.to_i)
    album.stock_update(params["sold"][sold_album_id].to_i)
  end

  redirect to '/artist/inventory'
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

get '/artist/profile' do
  erb(:new_profile)
end

post '/artist/profile' do
  @artist = Artist.new(params)
  @artist.save()
  @albums = Album.new(params)
  @albums.artist_id = @artist.id
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
  @artists = Artist.all
  @album = Album.find(params[:id])
  erb(:edit_album)
end

post '/album/:id' do
  @album = Album.new(params)
  artist_id = @album.artist_id
  @album.update()
  erb(:update)
end
