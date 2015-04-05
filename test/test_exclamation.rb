require 'minitest/autorun'
require 'exclamation'

class ExclamationTest < Minitest::Test

  def setup
    Exclamation.configuration.reload!
  end

  def test_class_methods_are_dynamically_created_from_configuration
    Exclamation::Configuration::EXCLAMATIONS.each do |exclamation|
      method_name = exclamation[0..-2] # Exclamation responds to the singular exclamation

      assert_respond_to Exclamation, method_name
    end
  end

  def test_class_methods_return_random_string_from_configuration_array
    Exclamation::Configuration::EXCLAMATIONS.each do |exclamation|
      exclamations_array = Exclamation::Configuration.new.send(:load_default_yaml, exclamation)
      returned_string = Exclamation.send(exclamation[0..-2])

      assert_includes exclamations_array, returned_string
    end
  end

  def test_configuration_returns_empty_configuration_object
    assert_equal Exclamation.configuration.class, Exclamation::Configuration
    assert_empty Exclamation.configuration.instance_variables
  end

  def test_configuration_returns_appropriately_configured_object_when_configure_is_provided
    Exclamation.configure {|config| config.positives = ['Funk yeah!']}

    assert_equal Exclamation.configuration.class, Exclamation::Configuration
    refute_empty Exclamation.configuration.instance_variables
    assert_equal Exclamation.configuration.instance_variables.count, 1
    assert_equal Exclamation.positive, 'Funk yeah!'
  end

end