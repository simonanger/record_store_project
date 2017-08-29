require('pg')
require_relative('../db/sql_runner')
require_relative('./album.rb')

class Artist

  attr_reader(:id)
  attr_accessor(:name)

  def initialize(params)
    @id = params['id'].to_i if params['id']
    @name = params['name']
  end

  def self.map_items(hash)
    return hash.map { |hash| Artist.new(hash) }
  end

  def save()
    sql = 'INSERT INTO artists (
    name
    ) VALUES (
    $1
    ) RETURNING id;'
    values = [@name]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i()
  end

  def self.all()
    sql = 'SELECT * FROM artists;'
    values = []
    artists = SqlRunner.run(sql, values)
    result = Artist.map_items(artists)
    return result
  end

  def self.find(id)
    sql = ' SELECT * FROM artists
    WHERE id = $1;'
    values = [id]
    result = SqlRunner.run(sql, values)
    return Artist.new(result[0])
  end

  def self.find_by_name(name)
    sql = ' SELECT * FROM artists WHERE name = $1'
    values = [name]
    result = SqlRunner.run(sql, values)

    return [] if result.to_a.length == 0

    artist_hash = result[0]
    artist_by_name = Artist.new(artist_hash)
    return artist_by_name
  end

  def self.albums(id)
    sql = ' SELECT * FROM albums WHERE artist_id = $1;'
    values = [id]
    result = SqlRunner.run(sql, values)
    return Album.map_items(result)
  end

  def Artist.sort_by_name()
    return Artist.all.sort_by{|artist| artist.name}
  end

  def self.names()
    sql = 'SELECT * FROM artists;'
    artist_array = SqlRunner.run(sql, [])
    artists = Artist.all
    names = artists.map {|artists| artists.name}
    return names
  end

  def update()
    sql = 'UPDATE artists SET (
    name) = (
    $1)
    WHERE id = $2;'
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = 'DELETE FROM artists
    WHERE id = $1;'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = 'DELETE FROM artists'
    SqlRunner.run(sql)
  end

  def self.search(search)
    where("name ilike ?", "#{search}")
  end

end
