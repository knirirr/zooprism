Gem::Specification.new do |s|
  s.name        = 'zooprism'
  s.version     = '0.0.0'
  s.date        = '2013-03-13'
  s.summary     = "Generate stats on what Zooniverse users are up to."
  s.description = "Connect Zooniverse to Redshift"
  s.authors     = ["Milo Thurston"]
  s.email       = 'milo.thurston@oerc.ox.ac.uk'
  s.files       = ["lib/zooprism.rb",
                   "lib/zooprism/manage.rb",
                   "lib/zooprism/query.rb",
                   "lib/zooprism/read.rb",
                   "lib/zooprism/config.rb"]
  s.homepage    = 'http://zooniverse.org'
  s.license     = 'Apache'
end
