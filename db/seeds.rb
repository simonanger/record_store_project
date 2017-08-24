require_relative('../models/artist')
require_relative('../models/album')
require ('pry')

artist1 = Artist.new({'name' => 'King Witch', 'logo' => 'logo.url'})

artist1.save

album1 = Album.new({'title' => 'Shoulders of Giants',
  'artwork' => 'artwork.url',
  'stock' => '3',
  'artist_id' => artist1.id})

binding.pry
nil
