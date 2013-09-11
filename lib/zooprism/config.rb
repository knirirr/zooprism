# this should be set up in config/initializers 
# for the rails application
module ZPConfig

  @default_file = "#{ENV['HOME']}/.aws/config"
  @config = nil

  # Configure through yaml file
  def self.configure
    begin
      @config = IniFile.load(@default_file)
    rescue Errno::ENOENT
      puts "File #{@default_file} could not be found."
    rescue IniFile::Error
      puts "File #{@default_file} could not be parsed."
    end
  end

  # return dbh ready for queries
  def self.prepare
    #puts "Attempting to connect to database #{@config['database']['dbname']}..."
    begin
      return PG::Connection.new(:host => @config['database']['host'], 
                                :port => @config['database']['port'],
                                :dbname => @config['database']['dbname'],
                                :user => @config['database']['user'],
                                :password => @config['database']['password'])
    rescue Exception => ex
      puts "Connection failed. Error #{ex.class} happened, message is: #{ex.message}"
    end
  end

  # NB the "prepare" code may have to be replaced with another means of getting database information, 
  # probably by querying the clusters to see what is available. This will be done later when I have a better
  # understanding

end

