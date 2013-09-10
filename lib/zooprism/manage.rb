class ZPManage
  include ZPConfig

  @client = nil

  def initialize
    @client = ZPConfig.connect
  end

  def working?
    puts "Who can say?"
  end

  # this should give details of all clusters but doesn't.
  # I can't authorise hosts properly either. Perhaps I don't have the right permissions
  # to perform cluster operations; I can't tell, though.
  def describe
    puts @client.describe_clusters
  end

end

