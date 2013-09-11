class ZPManage
  include ZPConfig

  def working?
    puts "Who can say?"
  end

  # the aws-sdk gem's commands use "_", but the command line
  # options and commands use "-", so I have done a crude gsub.
  def command(com,opts)
    optstring = "" 
    answer = {}
    if !opts.nil?
      opts.each_pair do |k,v|
        optstring += "--#{k.to_s.gsub(/_/,"-")} #{v} "
      end
    end
    begin
      answer= JSON.parse(`aws redshift #{com.gsub(/_/,"-")} #{optstring}`)
    rescue
      # do something - but what?
    end
    return answer
  end

end

