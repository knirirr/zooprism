class ZPManage
  include ZPConfig

  @client = nil

  def initialize
    @client = ZPConfig.connect
  end

  # use getclient to return a client which can
  # run the aws_sdk commands from here:
  # http://docs.aws.amazon.com/AWSRubySDK/latest/AWS/Redshift/Client.html
  def getclient
    return @client
  end

  def describe
    puts @client.describe_clusters
  end

end

