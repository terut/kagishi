require 'test_helper'

class Kagishi::ConfigurationTest < Minitest::Test
  def test_default_configuration
    assert_equal "HS256", Kagishi.configuration.algorithm
  end

  class RewriteConfigurationTest < Minitest::Test
    def setup
      Kagishi.configure do |config|
        config.algorithm = "HS512"
      end
    end

    def teardown
      Kagishi.configuration.reset
    end

    def test_rewrite_configuration
      assert_equal "HS512", Kagishi.configuration.algorithm
    end
  end
end
