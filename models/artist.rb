require('pg')
require_relative('../db/sql_runner')

class Artist

  attr_reader(:id)
  attr_accessor(:name, :logo)

  def initialize(params)
    @id = params['id'].to_i if params['id']
    @name = params['name']
    @logo = params['logo']
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


end
