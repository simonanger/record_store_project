require('pg')
require_relative('../db/sql_runner')
require_relative('./artist')

class Album

  attr_accessor(:id)
  attr_reader(:title, :artwork, :stock, :artist_id )

  def initialize( params )
    @id = params['id'].to_i if params['id']
    @title = params['title']
    @artwork = params['artwork']
    @stock = params['stock'].to_i()
    @artist_id = params['artist_id'].to_i()
  end

  def save()
    sql = 'INSERT INTO albums (
    title, artwork, stock, artist_id
    ) VALUES (
    $1, $2, $3, $4
    ) RETURNING id;'
    values = [@title, @artwork, @stock, @artist_id]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i()
  end

end
