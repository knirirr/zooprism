class ZPRead
  include ZPConfig

  @dbh = nil

  # http://deveiate.org/code/pg/PGconn.html
  def initialize
    @dbh = ZPConfig.prepare(:ro => true)
  end

  def get_handle
    return @dbh
  end

  def close
    if !@dbh.nil?
      @dbh.finish
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
