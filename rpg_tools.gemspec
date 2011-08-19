Gem::Specification.new do |s|
	s.name = "rpg-tools"
	s.version = "0.1.0"
	s.authors = ["Eduardo Casanova Cuesta"]
	s.summary = "Some tools useful when creating a RPG: Die, Throw and CheckRoll."
	s.description = "Some tools useful when creating a RPG: Die, Throw and CheckRoll."
	s.email = "ecasanovac@gmail.com"
	s.homepage = "https://github.com/roendal/rpg-tools"
	s.files = `git ls-files`.split("\n")

	# Gem dependencies
	#
	
	# Development Gem dependencies
	#
  s.add_runtime_dependency('rails', '~> 3.0.0')
	# Testing database
	s.add_development_dependency('sqlite3-ruby')
	# Debugging
	if RUBY_VERSION < '1.9'
		s.add_development_dependency('ruby-debug', '~> 0.10.3')
	end
	# Specs
	s.add_development_dependency('rspec-rails', '~> 2.6.1')
	# Fixtures
	s.add_development_dependency('factory_girl', '~> 1.3.2')
	# Population
	s.add_development_dependency('forgery', '~> 0.3.6')
	# Integration testing
	s.add_development_dependency('capybara', '~> 0.3.9')
end

