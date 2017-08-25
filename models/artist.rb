require('pg')
require_relative('../db/sql_runner')
require_relative('./album.rb')

class Artist

  attr_reader(:id)
  attr_accessor(:name, :logo)

  def initialize(params)
    @id = params['id'].to_i if params['id']
    @name = params['name']
    @logo = params['logo']
  end

  def self.map_items(hash)
    return hash.map { |hash| Artist.new(hash) }
  end

  def save()
    sql = 'INSERT INTO artists (
    name, logo
    ) VALUES (
    $1, $2
    ) RETURNING id;'
    values = [@name, @logo]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i()
  end

  def self.all()
    sql = 'SELECT * FROM artists'
    values = []
    artists = SqlRunner.run(sql, values)
    result = Artist.map_items(artists)
    return result
  end

  def self.find(id)
    sql = ' SELECT * FROM artists
    WHERE id = $1'
    values = [id]
    result = SqlRunner.run(sql, values)
    return Artist.new(result[0])
  end

  def albums()
    sql = ' SELECT * FROM albums WHERE artist_id = $1'
    values = [id]
    result = SqlRunner.run(sql, values)
    return Album.map_items(result)
  end

end
