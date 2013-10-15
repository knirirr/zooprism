class ZPManage
  include ZPConfig

  @client = nil

  def initialize
    @client = ZPConfig.connect
  end

  def getclient
    return @client
  end

  def working?
    puts "Who can say?"
  end

  def describe
    puts @client.describe_clusters
  end

end

