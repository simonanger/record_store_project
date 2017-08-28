require('pg')
require_relative('../db/sql_runner')
require_relative('./artist')

class Album

  attr_reader(:id)
  attr_accessor(:title, :artwork, :genre, :stock, :cost, :sale, :sold, :artist_id )

  def initialize(params)
    @id = params['id'].to_i if params['id']
    @title = params['title']
    @artwork = params['artwork']
    @genre = params['genre']
    @stock = params['stock'].to_i()
    @cost = params['cost'].to_i()
    @sale = params['sale'].to_i()
    @sold = params['sold'].to_i()
    @artist_id = params['artist_id']
  end

  def self.map_items(hash)
    return hash.map { |hash| Album.new(hash) }
  end

  def save()
    sql = 'INSERT INTO albums (
    title, artwork, genre, stock, cost, sale, sold, artist_id
    ) VALUES (
    $1, $2, $3, $4, $5, $6, $7, $8
    ) RETURNING id;'
    values = [@title, @artwork, @genre, @stock, @cost, @sale, @sold, @artist_id]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i()
  end

  def self.all()
    sql = 'SELECT * FROM albums;'
    values = []
    albums = SqlRunner.run(sql, values)
    result = Album.map_items(albums)
    return result
  end

  def self.find(id)
    sql = ' SELECT * FROM albums
    WHERE id = $1;'
    values = [id]
    result = SqlRunner.run(sql, values)
    return Album.new(result[0])
  end

  def artist()
    sql = ' SELECT * FROM artists WHERE id = $1;'
    values = [@artist_id]
    result = SqlRunner.run(sql, values)
    return Artist.map_items(result)
  end

  def artist_name()
    sql = ' SELECT * FROM artists WHERE id = $1;'
    values = [@artist_id]
    result = SqlRunner.run(sql, values)
    return Artist.map_items(result).first.name
  end


  def Album.sort_by_title()
    return Album.all.sort_by{|album| album.title}
  end

  def stock_level
    return "Out of stock" if @stock == 0
    return "Stock level: Low" if @stock <= 5
    return "Stock level: Medium" if @stock <= 10
    return "Stock level: High" if @stock >=10
  end

  def delete()
    sql = "DELETE FROM albums
    WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = 'DELETE FROM albums'
    SqlRunner.run(sql)
  end

  def update()
    sql = 'UPDATE albums SET (
    title, artwork, genre, stock, cost, sale, sold) =
    ($1, $2, $3, $4, $5, $6, $7)
    WHERE id = $8;'
    values = [@title, @artwork, @genre, @stock, @cost, @sale, @sold, @id]
    SqlRunner.run(sql, values)
  end

  def stock_update(number_sold)
    @stock -= number_sold
    @sold += number_sold
    self.update
  end

  def profit()
    profit = @sale - @cost
    return profit
  end
end
