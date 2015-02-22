# Exclamation #

A random exclamation generator. Niiiiice!

## About ##

`Exclamation` is a random word generator built in [Ruby](https://www.ruby-lang.org/en/) that returns exclamations like "Hello", "Uh oh" and "Booyah".

## Usage ##
Exclamations can be positive, negative, indifferent or greetings and partings.

```ruby
Exclamation.positive    => 'Nice'
Exclamation.negative    => 'Drat'
Exclamation.indifferent => 'Hmm'
Exclamation.greeting    => 'Hiya'
Exclamation.parting     => 'See you'
```

## Configuration ##
If you don't like the included lists you can add, remove or completely override the defaults. The config takes either an array of strings, or a path to a YAML file. Inside of some configuration file:

```ruby
Exclamation.configure do |config|
  # Completely override the defaults with your own list
  config.positives = 'path/to/your/own/custom/list.yml'

  # Append the defaults
  config.include_positives = ['Shaawiing', 'Aww schuky ducky']

  # Remove anything you don't like from the defaults
  config.exclude_positives = ['Bingo', 'Woo']
end
```

## Note ##

Currently in 0.0.1 alpha for a side project. Some day soon `Exclamation` will graduate to a beta!