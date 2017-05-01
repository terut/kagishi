require 'test_helper'

class Kagishi::ConfigurationTest < Minitest::Test
  def test_default_configuration
    assert_equal "HS256", Kagishi.configuration.algorithm
    assert_equal 15 * 60, Kagishi.configuration.ttl
    assert_equal "", Kagishi.configuration.secret
  end

  class RewriteConfigurationTest < Minitest::Test
    def setup
      Kagishi.configure do |config|
        config.algorithm = "HS512"
        config.ttl = 1
        config.secret = "my$ecretK3y"
      end
    end

    def teardown
      Kagishi.configuration.reset
    end

    def test_rewrite_configuration
      assert_equal "HS512", Kagishi.configuration.algorithm
      assert_equal 1, Kagishi.configuration.ttl
      assert_equal "my$ecretK3y", Kagishi.configuration.secret
    end
  end
end
