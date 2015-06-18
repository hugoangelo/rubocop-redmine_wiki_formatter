$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'rubocop/redmine_wiki_formatter/version'

Gem::Specification.new do |spec|
  spec.name = 'rubocop-redmine_wiki_formatter'
  spec.summary = 'Formatter for Redmine Wiki page'
  spec.description = <<-end_description
    Formatter for Redmine Wiki page.
    A formatter for the RuboCop tool that outputs in Redmine Wiki markup.
  end_description
  spec.homepage = 'http://github.com/hugoangelo/rubocop-redmine_wiki_formatter'
  spec.authors = ['Hugo Angelo']
  spec.email = ['hugoangelo@gmail.com']
  spec.licenses = ['MIT']

  spec.version = RuboCop::RedmineWikiFormatter::Version::STRING
  spec.platform = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 1.9.3'

  spec.require_paths = ['lib']
  spec.files = Dir[
    '{lib,spec}/**/*',
    '*.md',
    '*.gemspec',
    'Gemfile',
    'Rakefile'
  ]
  spec.test_files = Dir['{spec}/**/*']
  spec.extra_rdoc_files = ['README.md']

  spec.add_development_dependency('rubocop', '~> 0.24')
  spec.add_development_dependency('rake', '~> 10.1')
  spec.add_development_dependency('rspec', '~> 3.2')
end
