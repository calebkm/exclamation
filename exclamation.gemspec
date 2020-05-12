$LOAD_PATH.push File.expand_path('../lib', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'exclamation'
  s.version     = '0.1.6'
  s.date        = '2020-05-11'
  s.summary     = 'A random exclamation generator.'
  s.description = 'Returns a random exclamation - like "Wow" - from a configurable list.'
  s.authors     = ['Caleb K Matthiesen']
  s.email       = 'c@calebkm.com'
  s.files       = ['lib/exclamation.rb']
  s.homepage    = 'http://github.com/calebkm/exclamation'
  s.license     = 'MIT'
end