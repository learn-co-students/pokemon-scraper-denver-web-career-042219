require "pry"

class Pokemon
  attr_reader
  attr_writer
  attr_accessor :id, :name, :type, :db, :hp

  def initialize(attr_array, db)
    @id, @name, @type, @hp =*attr_array
    @db = db
    # @hp = hp
    # is this duplicate work?
    # the hp is optional, it is not required to initialize an opbject but is auto defualted to nil \
  end

  def self.save(name, type, db)  #positional not defined

    sql = <<-SQL
      INSERT INTO pokemon(name, type)
      VALUES(?, ?)
    SQL

    db.execute(sql, name, type)

    #why do we go from DB[:conn] to db?
    #are the db here the same?
  end

  def self.find(id, db)

    # binding.pry

    sql = <<-SQL
      SELECT *
      FROM pokemon
      WHERE id = ?
    SQL

    # sql2 = <<-SQL
    #   SELECT *
    #   FROM pokemon
    # SQL
    #
    # db.execute(sql2)


    db.execute(sql, id).map do |row|

      Pokemon.new(id: row[0], name: row[1], type: row[2], db: db)

    end.first #The .first is v important!!! returns an array, get down one level

  end


  def alter_hp(hp, db)

    # binding.pry
    # self.hp = hp

    sql = <<-SQL
      UPDATE pokemon
      SET hp = ?
      WHERE ID = ?
    SQL


    db.execute(sql, hp, self.id)
    # binding.pry

  end

  #is this saving or storing two separate objects?  the instance and the db value?
  #It is not adding the HP column in the data base I THINK
  # there is an issue between the named parameters and when I change and pass in new ones
# expect(Pokemon.find(1, @db).hp).to eq(59)

    # binding.pry
end
