# frozen_string_literal: true

require_relative 'lib/rubocop_fonsan_style/version'

Gem::Specification.new do |spec|
  spec.name = 'rubocop_fonsan_style'
  spec.version = RubocopFonsanStyle::VERSION
  spec.authors = ['Fonsan']
  spec.email = ['fonsan@gmail.com']

  spec.summary = 'Fonsan rubocop'
  spec.description = 'An opionated rubocop style'
  spec.homepage = 'https://github.com/Fonsan/rubocop_fonsan_style'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.6.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) {|f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  spec.add_dependency 'rubocop', '~> 1.39'
  spec.add_dependency 'rubocop-performance', '~> 1.15'
  spec.add_dependency 'rubocop-rails', '~> 2.17'
  spec.add_dependency 'rubocop-rake', '~> 0.6.0'
  spec.add_dependency 'rubocop-rspec', '~> 2.15'
  spec.add_dependency 'rubocop-rubycw', '~> 0.1'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata['rubygems_mfa_required'] = 'true'
end
