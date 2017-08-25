require_relative('../models/artist')
require_relative('../models/album')
require ('pry')

Album.delete_all
Artist.delete_all

artist1 = Artist.new({'name' => 'King Witch', 'logo' => 'logo.url'})
artist2 = Artist.new({'name' => 'Dune', 'logo' => 'logo.url'})
artist3 = Artist.new({'name' => 'Converge', 'logo' => 'logo.url'})

artist1.save
artist2.save
artist3.save

album1 = Album.new({'title' => 'Shoulders of Giants',
  'artwork' => '/shoulders.jpeg',
  'genre' => 'Metal',
  'stock' => '3',
  'artist_id' => artist1.id})
album2 = Album.new({'title' => 'Under the Mountain',
  'artwork' => '/under.jpeg',
  'genre' => 'Metal',
  'stock' => '10',
  'artist_id' => artist1.id})
album3 = Album.new({'title' => 'Progenitor',
  'artwork' => '/progenitor.jpeg',
  'genre' => 'Metal',
  'stock' => '5',
  'artist_id' => artist2.id})
album4 = Album.new({'title' => 'Aurora Majesty',
  'artwork' => '/aurora.jpeg',
  'genre' => 'Metal',
  'stock' => '1',
  'artist_id' => artist2.id})
album5 = Album.new({'title' => 'Jane Doe',
  'artwork' => '/jane.jpeg',
  'genre' => 'Hardcore',
  'stock' => '7',
  'artist_id' => artist3.id})
album6 = Album.new({'title' => 'You Fail Me',
  'artwork' => '/fail.jpeg',
  'genre' => 'Hardcore',
  'stock' => '15',
  'artist_id' => artist3.id})

  album1.save
  album2.save
  album3.save
  album4.save
  album5.save
  album6.save

binding.pry
nil
