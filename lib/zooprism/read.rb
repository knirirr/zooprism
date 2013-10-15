class ZPQuery
  include ZPConfig

  @dbh = nil

  # http://deveiate.org/code/pg/PGconn.html
  def initialize
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

  def copy(table,bucket,options = {})
    options = {:delimiter => ','}.merge(options)
    @config = ZPConfig.config
    query = "copy #{table} from '#{bucket}' credentials 'aws_access_key_id=#{@config[:access_key_id]};aws_secret_access_key=#{@config[:secret_access_key]}' delimiter as '#{options[:delimiter]}'"
    run_query(query)
    #return query
  end

end
