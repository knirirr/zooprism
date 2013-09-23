zooprism
========

Gem for Redshift queries/management, in development.

As the aws-sdk gem appears not to work, this gem assumes the presence of the aws command line services, with a config file in ~/.aws/config. 

Querying can be done thus:

zq = ZPQuery.new
result = zq.run_query("select * from stuff")

Management is as follows:

zm = ZPManage.new
status = zm.describe

These need padding out quite a lot.

Before the sql gets as far as ZPQuery it should be dynamically checked in the browser to at least make sure that the users send valid sql to the server, to avoid wasting too much time (see query.rb for link).This is currently being done by OBOE.
