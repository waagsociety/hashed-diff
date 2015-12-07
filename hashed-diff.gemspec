Gem::Specification.new do |s|
  s.name        = 'hashed-diff'
  s.version     = '1.0.0'
  s.date        = '2015-12-07'
  s.summary     = "Memory efficient diff wrapper"
  s.description = "The hashed-diff ruby script is a reasonably fast, memory efficient script that wraps diff for very large files (4Gb)."
  s.authors     = ["Taco van Dijk","Lodewijk Loos"]
  s.email       = ["taco@waag.org","lodewijk@waag.org"]
  s.files       = ["bin/hashed-diff"]
  s.executables = ["hashed-diff"]
  s.homepage    = 'https://github.com/waagsociety/hashed-diff'
  s.license     = 'MIT'
  s.add_runtime_dependency "xxhash","~> 0.3.0"
end
