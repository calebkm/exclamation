module Exclamation
  class Configuration

    EXCLAMATIONS = [:positives, :indifferents, :negatives, :greetings, :partings]
    DEFAULT_LOCALE = :en
    
    def initialize
      yield(self) if block_given?
    end

    def default_locale
      (@locale || DEFAULT_LOCALE).to_s
    end

    def default_locale=(locale)
      @locale = locale
    end

    EXCLAMATIONS.each do |exclamation|
      define_method(exclamation) do |locale|
        locale = locale || default_locale
        get_or_set_instance_variable(exclamation, locale)
      end
    end

    def method_missing(method, *args)
      # match methods like "greetings=" and "greetings_en="
      if method.to_s =~ /^([a-z]+)(?:_)?([a-z]+)?=$/ && EXCLAMATIONS.include?($1.to_sym)
        instance_variable_set("@#{$1}_#{$2 || default_locale}", load_content(args.first))
      # match methods like "include_greetings=" and "include_greetings_en="
      elsif method.to_s =~ /^include_([a-z]+)(?:_)?([a-z]+)?=$/ && EXCLAMATIONS.include?($1.to_sym)
        instance_variable_set("@#{$1}_#{$2 || default_locale}", send($1, $2) + load_content(args.first))
      # match methods like "exclude_greetings=" and "exclude_greetings_en="
      elsif method.to_s =~ /^exclude_([a-z]+)(?:_)?([a-z]+)?=$/ && EXCLAMATIONS.include?($1.to_sym)
        instance_variable_set("@#{$1}_#{$2 || default_locale}", send($1, $2) - load_content(args.first))
      else
        super
      end
    end

    def reload!
      instance_variables.each do |var|
        remove_instance_variable(var)
      end
    end

  private

    def get_or_set_instance_variable(var, locale)
      instance = instance_variable_get("@#{var}_#{locale}")
      instance || instance_variable_set("@#{var}_#{locale}", load_default_yaml(var))
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
