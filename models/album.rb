require('pg')
require_relative('../db/sql_runner')
require_relative('./artist')

class Album

  attr_accessor(:id)
  attr_reader(:title, :artwork, :genre, :stock, :artist_id )

  def initialize( params )
    @id = params['id'].to_i if params['id']
    @title = params['title']
    @artwork = params['artwork']
    @genre = params['genre']
    @stock = params['stock'].to_i()
    @artist_id = params['artist_id']
  end

  def self.map_items(hash)
    return hash.map { |hash| Album.new(hash) }
  end

  def save()
    sql = 'INSERT INTO albums (
    title, artwork, genre, stock, artist_id
    ) VALUES (
    $1, $2, $3, $4, $5
    ) RETURNING id;'
    values = [@title, @artwork, @genre, @stock, @artist_id]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i()
  end

  def self.all()
    sql = 'SELECT * FROM albums'
    values = []
    albums = SqlRunner.run(sql, values)
    result = Album.map_items(albums)
    return result
  end

  def self.find(id)
    sql = ' SELECT * FROM albums
    WHERE id = $1'
    values = [id]
    result = SqlRunner.run(sql, values)
    return Album.new(result[0])
  end

  def artist()
    sql = ' SELECT * FROM artists WHERE artist_id = $1'
    values = [id]
    result = SqlRunner.run(sql, values)
    return Artist.map_items(result)
  end

  def Album.sort_by_title()
    return Album.all.sort_by{|album| album.title}
  end

end
