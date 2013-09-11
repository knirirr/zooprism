class ZPQuery
  include ZPConfig

  @dbh = nil

  # http://deveiate.org/code/pg/PGconn.html
  def initialize
    ZPConfig.configure
    @dbh = ZPConfig.prepare
  end

  def get_handle
    return @dbh
  end

  def close
    if !@dbh.nil?
      @dbh.finish
    end
  end

  def test_insert
    # users should only have read permission anyway, although it is not clear
    # how to ensure this with Redshift
    begin
      res = @dbh.exec("insert into fruits values('banana','yellow')")
      res = @dbh.exec("insert into fruits values('orange','green')")
    rescue PG::Error => err
      puts err
    end
  end

  def test_query
    # this still needs checking before it goes to the server - 
    # should be done in the browser before user even gets this far, e.g.
    # https://github.com/forward/sql-parser
    begin
      res = @dbh.exec("select * from fruits")
      res.each_row do |r|
        puts r.to_s 
      end
    rescue PG::Error => err
      puts err
    end
  end

  def run_query(sql)
    output = Array.new
    begin
      res = @dbh.exec(sql)
      res.each_row do |r|
        output << r
      end
    rescue PG::Error => err
      puts err
    end
    return output
  end

end
