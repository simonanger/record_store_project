require('sinatra')
require('sinatra/contrib/all') if development?
require_relative('../models/album')
require_relative('../models/artist')
require('pry')
also_reload('.models/*')

get '/artist' do
  erb(:'artist/home')
end

get '/artist/all' do
  @artists = Artist.sort_by_name
  erb(:'artist/index')
end

get '/artist/inventory' do
  @albums = Album.all.sort_by {|album| album.artist_name}
  erb(:'artist/inventory')
end

post '/artist/inventory' do
  all_album_ids = params["sold"].keys
  sold_album_ids = all_album_ids.select { |album_id| params["sold"][album_id] != "" }

  for sold_album_id in sold_album_ids
    album = Album.find(sold_album_id.to_i)
    album.stock_update(params["sold"][sold_album_id].to_i)
  end

  all_album_ids2 = params["bought"].keys
  bought_album_ids = all_album_ids2.select { |album| params["bought"][album] != "" }

  for bought_album_id in bought_album_ids
    album = Album.find(bought_album_id.to_i)
    album.stock_add(params["bought"][bought_album_id].to_i)
  end

  redirect to '/artist/inventory'
end

get '/artist/new' do
  erb(:'artist/new_artist')
end

post '/artist' do
  @artist = Artist.new(params)
  @artist.save()
  redirect to '/artist/all'
end

get '/artist/:id/new' do
  @artists = Artist.all
  @album = Album.find(params[:id])
  erb(:'album/new_album_id')
end

post '/artist/:artist_id/new' do
  @album = Album.new(params)
  artist_id = @album.artist_id
  @album.save
  erb(:'artist/update')
end

get '/artist/profile' do
  erb(:'artist/new_profile')
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

get '/artist/:id' do
  @artist = Artist.find(params[:id])
  @albums = Artist.albums(@artist.id)
  erb(:'artist/show')
end

get '/artist/:id/edit' do
  @artist = Artist.find(params[:id])
  erb(:'artist/edit_artist')
end

post '/artist/:id' do
  @artist = Artist.new(params)
  @artist.update()
  redirect to "/artist/all"
end
