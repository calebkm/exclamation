module Exclamation
  class Configuration

    EXCLAMATIONS = [:positives, :indifferents, :negatives, :greetings, :partings]

    def initialize
      yield(self) if block_given?
    end

    def defaults(name)
      load_default_yaml(name)
    end

    def reload!
      instance_variables.each do |var|
        remove_instance_variable(var)
      end
    end

    EXCLAMATIONS.each do |exclamation|
      define_method(exclamation) do
        get_or_set_instance_variable(exclamation)
      end

      define_method("#{exclamation}=") do |content|
        instance_variable_set("@#{exclamation}", load_content(content))
      end

      define_method("include_#{exclamation}") do |content|
        instance_variable_set("@#{exclamation}", send(exclamation) + load_content(content))
      end

      define_method("exclude_#{exclamation}=") do |content|
        instance_variable_set("@#{exclamation}", send(exclamation) - load_content(content))
      end
    end

  private

    def get_or_set_instance_variable(var)
      instance = instance_variable_get("@#{var}")
      instance || instance_variable_set("@#{var}", load_default_yaml(var))
    end

    def load_content(content)
      case content
      when Array  then load_array_or_raise(content)
      when String then load_yaml_or_raise(content)
      end
    end

    def load_array_or_raise(array)
      (!array.empty? && array) || raise(ConfigurationEmptyArray)
    end

    def load_yaml_or_raise(filepath)
      (File.exists?(filepath) && load_yaml(filepath)) || raise(ConfigurationFileNotFound)
    end

    def load_default_yaml(name)
      load_yaml(File.dirname(__FILE__) + "/../../config/#{name}.yml")
    end

    def load_yaml(path)
      YAML.load_file(path)
    end
  end
end
