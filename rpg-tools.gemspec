Gem::Specification.new do |s|
	s.name = "rpg-tools"
	s.version = "0.2.3"
	s.authors = ["Eduardo Casanova Cuesta"]
	s.summary = "RPG Tools is a compilation of helpful tools when developing a Role Playing Game (RPG). For now the gem has three classes: Die, Throw and CheckRoll. "
	s.description = "RPG Tools is a compilation of helpful tools when developing a Role Playing Game (RPG). For now the gem has three classes: Die, Throw and CheckRoll."
	s.email = "ecasanovac@gmail.com"
	s.homepage = "https://github.com/roendal/rpg-tools"
	s.files = `git ls-files`.split("\n")

	# Gem dependencies
	#
  s.add_runtime_dependency 'rails', '>= 3.0.0'
	
	# Development Gem dependencies
	#
	# Testing database
	s.add_development_dependency 'sqlite3-ruby'
	# Debugging
	if RUBY_VERSION < '1.9'
		s.add_development_dependency 'ruby-debug'
	end
	# Specs
	s.add_development_dependency 'rspec-rails'
	# Fixtures
	s.add_development_dependency 'factory_girl'
	# Integration testing
	s.add_development_dependency 'capybara'
end

