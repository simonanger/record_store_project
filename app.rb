require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('controllers/artist_controller')
require_relative('controllers/album_controller')

get '/' do
  erb(:'artist/home')
end
