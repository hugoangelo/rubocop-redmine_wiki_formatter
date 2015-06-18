# RuboCop Redmine Wiki Formatter

Redmine Wiki Page Formatter, as an extension to [RuboCop](https://github.com/bbatsov/rubocop).


## Installation

Just install the `rubocop-redmine_wiki_formatter` gem

```bash
gem install rubocop-redmine_wiki_formatter
```

or if you use bundler put this in your `Gemfile`

```
gem 'rubocop-redmine_wiki_formatter', require: false
```


## Usage

You need to tell RuboCop to load the RedmineWikiFormatter extension. There are three
ways to do this:

### RuboCop configuration file

Put this into you `.rubocop.yml`.

```
require: redmine_wiki_formatter
```

Now you can run `rubocop --format RuboCop::Formatter::RedmineWikiFormatter` and it will automaticly format the output
to Redmine's Wiki format.

### Command line

```bash
rubocop --require redmine_wiki_formatter --format RuboCop::Formatter::RedmineWikiFormatter
```

### Rake task

```ruby
RuboCop::RakeTask.new do |task|
  task.requires << 'redmine_wiki_formatter'
  task.options = ['--format', 'RuboCop::Formatter::RedmineWikiFormatter']
end
```

## License

`rubocop-redmine_wiki_formatter` is [MIT licensed](http://opensource.org/licenses/MIT).