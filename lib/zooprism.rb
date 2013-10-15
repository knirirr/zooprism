# http://aws.amazon.com/sdkforruby/

require 'logger'
require 'json'
require 'pg'
require 'yaml'
require 'aws-sdk'

require 'zooprism/config'
require 'zooprism/manage'
require 'zooprism/query'
require 'zooprism/read'

YAML::ENGINE.yamler = 'syck'

=begin
To set this up, a redshift.yml file should be provided and sourced with an initialiser, thus:

ZPConfig.configure_with("#{Rails.root}/config/redshift.yml")

Then, every time a sidekiq job needs to query AWS or perform a query, an appropriate object can
be created, e.g.

zq = ZPQuery.new
result = zq.run_query("select * from stuff")
...&c.

zm = ZPManage.new
status = zm.describe
...&c.

These need padding out quite a lot.

Before the sql gets as far as ZPQuery it should be dynamically checked in the browser to at least make sure that the users send valid sql to the server, to avoid wasting too much time (see query.rb for link).

=end
