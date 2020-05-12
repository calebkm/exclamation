require 'minitest/autorun'
require 'exclamation'

class Exclamation::ConfigurationTest < Minitest::Test
  def setup
    @configuration = Exclamation::Configuration.new
  end

  def test_default_locale
    assert_equal @configuration.default_locale, Exclamation::Configuration::DEFAULT_LOCALE.to_s
  end

  def test_default_locale_setter
    @configuration.default_locale = :fr

    assert_equal @configuration.default_locale, 'fr'
  end

  def test_reload!
    @configuration.positives = ['Nice one, dude!']
    @configuration.reload!

    assert_empty @configuration.instance_variables
  end

  def test_responds_to_dynamically_created_instance_methods
    Exclamation::Configuration::EXCLAMATIONS.each do |exclamation|
      assert_respond_to @configuration, exclamation
    end
  end

  def test_instance_method_setters_via_method_missing
    method = Exclamation::Configuration::EXCLAMATIONS.first.to_s + '='
    args = ['Super duper']

    assert @configuration.send(method, args).include?(args.first)
  end

  def test_instance_method_setters_with_i18n_locale_via_method_missing
    method = Exclamation::Configuration::EXCLAMATIONS.first.to_s + '_fr='
    args = ['Bien']

    assert @configuration.send(method, args).include?(args.first)
  end

  def test_include_instance_method_setters_via_method_missing
    method = 'include_' + Exclamation::Configuration::EXCLAMATIONS.first.to_s + '='
    args = ['Super duper']

    assert @configuration.send(method, args).include?(args.first)
  end

  def test_include_instance_method_setters_with_i18n_locale_via_method_missing
    method = 'include_' + Exclamation::Configuration::EXCLAMATIONS.first.to_s + '_en='
    args = ['Super duper']

    assert @configuration.send(method, args).include?(args.first)
  end

  def test_exclude_instance_method_setters_via_method_missing
    method = 'exclude_' + Exclamation::Configuration::EXCLAMATIONS.first.to_s + '='
    args = ['Great']

    assert !@configuration.send(method, args).include?(args.first)
  end

  def test_exclude_instance_method_setters_with_i18n_locale_via_method_missing
    method = 'exclude_' + Exclamation::Configuration::EXCLAMATIONS.first.to_s + '_en='
    args = ['Great']

    refute @configuration.send(method, args).include?(args.first)
  end

  def test_private_instance_method_get_or_set_instance_variable
    assert_equal @configuration.send(:get_or_set_instance_variable, :positives, :en).class, Array
  end

  def test_private_instance_method_load_content_takes_array
    assert_equal @configuration.send(:load_content, ['Hello']).class, Array
  end

  def test_private_instance_method_load_content_takes_string
    assert_equal @configuration.send(:load_content, 'config/positives.yml').class, Array
  end

  def test_private_instance_method_load_array_or_raise
    assert_equal @configuration.send(:load_array_or_raise, ['Hello']).class, Array
    assert_raises(Exclamation::ConfigurationEmptyArray) { @configuration.send(:load_array_or_raise, []) }
  end

  def test_private_instance_method_load_yaml_or_raise
    assert_equal @configuration.send(:load_yaml_or_raise, 'config/positives.yml').class, Array
    assert_raises(Exclamation::ConfigurationFileNotFound) { @configuration.send(:load_yaml_or_raise, '') }
  end

  def test_private_instance_method_load_yaml
    assert_equal @configuration.send(:load_yaml, 'config/positives.yml').class, Array
  end
end