require_relative('../models/artist')
require_relative('../models/album')
require ('pry')

Album.delete_all
Artist.delete_all

artist1 = Artist.new({'name' => 'King Witch', 'logo' => 'logo.url'})
artist2 = Artist.new({'name' => 'Dune', 'logo' => 'logo.url'})
artist3 = Artist.new({'name' => 'Converge', 'logo' => 'logo.url'})
artist4 = Artist.new({'name' => 'Ice Cube', 'logo' => 'logo.url'})
artist5 = Artist.new({'name' => 'Pink Floyd', 'logo' => 'logo.url'})

artist1.save
artist2.save
artist3.save
artist4.save
artist5.save

album1 = Album.new({'title' => 'Shoulders of Giants',
  'artwork' => '/album_artwork/shoulders.jpeg',
  'genre' => 'Metal',
  'stock' => '3',
  'cost' => '2',
  'sale' => '3',
  'sold' => '7',
  'artist_id' => artist1.id})
album2 = Album.new({'title' => 'Under the Mountain',
  'artwork' => '/album_artwork/under.jpeg',
  'genre' => 'Metal',
  'stock' => '10',
  'cost' => '5',
  'sale' => '10',
  'sold' => '3',
  'artist_id' => artist1.id})
album3 = Album.new({'title' => 'Progenitor',
  'artwork' => :'/album_artwork/progenitor.jpeg',
  'genre' => 'Metal',
  'stock' => '5',
  'cost' => '3',
  'sale' => '5',
  'sold' => '6',
  'artist_id' => artist2.id})
album4 = Album.new({'title' => 'Aurora Majesty',
  'artwork' => '/album_artwork/aurora.jpeg',
  'genre' => 'Metal',
  'stock' => '1',
  'cost' => '2',
  'sale' => '3',
  'sold' => '10',
  'artist_id' => artist2.id})
album5 = Album.new({'title' => 'Jane Doe',
  'artwork' => '/album_artwork/jane.jpeg',
  'genre' => 'Hardcore',
  'stock' => '7',
  'cost' => '5',
  'sale' => '10',
  'sold' => '2',
  'artist_id' => artist3.id})
album6 = Album.new({'title' => 'You Fail Me',
  'artwork' => '/album_artwork/fail.jpeg',
  'genre' => 'Hardcore',
  'stock' => '15',
  'cost' => '7',
  'sale' => '15',
  'sold' => '5',
  'artist_id' => artist3.id})
album7 = Album.new({'title' => "AmeriKKa's Most Wanted",
  'artwork' => '/album_artwork/amw.jpeg',
  'genre' => 'Rap',
  'stock' => '10',
  'cost' => '3',
  'sale' => '10',
  'sold' => '8',
  'artist_id' => artist4.id})
album8 = Album.new({'title' => 'Death Certificate',
  'artwork' => '/album_artwork/dc.jpeg',
  'genre' => 'Rap',
  'stock' => '7',
  'cost' => '7',
  'sale' => '15',
  'sold' => '5',
  'artist_id' => artist4.id})
album9 = Album.new({'title' => 'The Predator',
  'artwork' => '/album_artwork/predator.jpg',
  'genre' => 'Rap',
  'stock' => '0',
  'cost' => '5',
  'sale' => '5',
  'sold' => '2',
  'artist_id' => artist4.id})
album10 = Album.new({'title' => 'Dark Side of the Moon',
  'artwork' => '/album_artwork/dark_side.png',
  'genre' => 'Rock',
  'stock' => '20',
  'cost' => '3',
  'sale' => '9',
  'sold' => '0',
  'artist_id' => artist5.id})
album11 = Album.new({'title' => 'Animals',
  'artwork' => '/album_artwork/animals.jpg',
  'genre' => 'Rock',
  'stock' => '3',
  'cost' => '5',
  'sale' => '7',
  'sold' => '3',
  'artist_id' => artist5.id})
album12 = Album.new({'title' => 'Wish You Were Here',
  'artwork' => '/album_artwork/wywh.png',
  'genre' => 'Rock',
  'stock' => '1',
  'cost' => '7',
  'sale' => '9',
  'sold' => '2',
  'artist_id' => artist5.id})

  album1.save
  album2.save
  album3.save
  album4.save
  album5.save
  album6.save
  album7.save
  album8.save
  album9.save
  album10.save
  album11.save
  album12.save

binding.pry
nil
