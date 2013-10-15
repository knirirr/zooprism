# this should be set up in config/initializers 
# for the rails application
module ZPConfig
  @config = {
              :access_key_id => "YOUR_ACCESS_KEY_ID",
              :secret_access_key => "YOUR_SECRET_ACCESS_KEY",
              :host => "HOST",
              :port => 5439,
              :dbname => "DBNAME",
              :user => "USER",
              :password => "SECRET",
              :ro_user => "USER",
              :ro_password => "SECRET"
            }

  @valid_config_keys = @config.keys

  def self.config
    @config
  end

  # Configure through hash
  def self.configure(opts = {})
    opts.each {|k,v| @config[k.to_sym] = v if @valid_config_keys.include? k.to_sym}
  end

  # Configure through yaml file
  def self.configure_with(path_to_yaml_file)
    begin
      config = YAML::load(IO.read(path_to_yaml_file))
    rescue Errno::ENOENT
      #log(:warning, "YAML configuration file couldn't be found. Using defaults."); return
      puts "YAML configuration file couldn't be found. Using defaults."
    rescue Psych::SyntaxError
      #log(:warning, "YAML configuration file contains invalid syntax. Using defaults."); return
      puts "YAML configuration file contains invalid syntax. Using defaults."
    end

    configure(config)
  end

  # return a redshift client
  def self.connect
    #AWS.config(@config)
    AWS.config(:access_key_id => @config[:access_key_id],
               :secret_access_key => @config[:secret_access_key], 
               :logger => Logger.new($stdout)) # this ought to log elsewhere...
    redshift = AWS::Redshift.new(config)
    return redshift.client
  end

  # return dbh ready for queries
  def self.prepare(options = {})
    options = {:ro => true}.merge(options)
    puts "Attempting to connect to #@config..."
    begin
      #return DBI.connect(@config[:db_name],
      #                   @config[:db_user],
      #                   @config[:db_pass],
      #                   'driver' => 'org.postgresql.Driver')   
      if options[:ro] == false
        return PG::Connection.new(:host => @config[:host], 
                                  :port => @config[:port],
                                  :dbname => @config[:dbname],
                                  :user => @config[:user],
                                  :password => @config[:password])
      else
        return PG::Connection.new(:host => @config[:host], 
                                  :port => @config[:port],
                                  :dbname => @config[:dbname],
                                  :user => @config[:ro_user],
                                  :password => @config[:ro_password])

      end
    rescue Exception => ex
      puts "Connection failed. Error #{ex.class} happened, message is: #{ex.message}"
    end
  end

end

