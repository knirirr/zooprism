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

In order to load data one can use the following commands:

    require 'zooprism'
    ZPConfig.configure_with("config.yml")
    zq = ZPQuery.new
    create = IO.read("schema.psql")
    zq.run_query(create)
    zq.copy('classifications','s3://bucket/data.csv',{:delimiter => (1).chr,:null => ''})

N.B. the ZPRead class is the same as ZPQuery except that it loads the configuration for the read-only user specified in the config.yml file; it is meant for dealing with queries from users.

Before the sql gets as far as ZPQuery it should be dynamically checked in the browser to at least make sure that the users send valid sql to the server, to avoid wasting too much time (see query.rb for link).This is currently being done by OBOE.
