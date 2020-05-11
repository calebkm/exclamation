Gem::Specification.new do |s|
  s.name        = 'exclamation'
  s.version     = '0.1.3'
  s.date        = '2019-07-12'
  s.summary     = 'A random exclamation generator.'
  s.description = 'Returns a random exclamation - like "Wow" - from a configurable list.'
  s.authors     = ['Caleb K Matthiesen']
  s.email       = 'c@calebkm.com'
  s.files       = ['lib/exclamation.rb']
  s.homepage    = 'http://github.com/calebkm/exclamation'
  s.license     = 'MIT'

  s.add_development_dependency 'rake', '~> 10.3'
  s.add_development_dependency 'minitest', '~> 5.4'
end