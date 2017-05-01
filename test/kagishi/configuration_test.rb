require 'test_helper'

class Kagishi::ConfigurationTest < Minitest::Test
  def test_default_configuration
    assert_equal "HS256", Kagishi.config.algorithm
    assert_equal 15 * 60, Kagishi.config.ttl
    assert_equal "", Kagishi.config.secret
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
      Kagishi.config.reset
    end

    def test_rewrite_configuration
      assert_equal "HS512", Kagishi.config.algorithm
      assert_equal 1, Kagishi.config.ttl
      assert_equal "my$ecretK3y", Kagishi.config.secret
    end
  end
end
