module Exclamation
  class ConfigurationFileNotFound < RuntimeError
    def initialize(message = 'Uh oh! Looks like your config filepath is incorrect.')
      super(message)
    end
  end

  class ConfigurationEmptyArray < RuntimeError
    def initialize(message = 'Whoops! Looks like your config Array is empty.')
      super(message)
    end
  end
end