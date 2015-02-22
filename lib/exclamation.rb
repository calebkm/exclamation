require 'exclamation/configuration'
require 'exclamation/error'
require 'yaml'

module Exclamation extend self

  def configure(&block)
    @configuration = Configuration.new(&block)
  end

  def configuration
    @configuration ||= Configuration.new
  end

  Configuration::EXCLAMATIONS.each do |exclamation|
    define_method(exclamation[0..-2]) do
      configuration.send(exclamation).sample
    end
  end

end