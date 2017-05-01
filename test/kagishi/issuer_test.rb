require 'test_helper'

class Kagishi::IssuerTest < Minitest::Test
  attr_accessor :token

  def setup
    @token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJmb28iOiJiYXIiLCJlbWFpbCI6ImFiY0BleGFtcGxlLmNvbSIsImV4cCI6MTQ4ODM5MjEwMH0.qObgICrz3rRiNng1c3GQ1Qu1wxZsBXKMbOAVhfz0sGQ"

    Timecop.freeze(Time.parse("2017-03-01T18:00:00Z").utc)
    Kagishi.configure do |config|
      config.secret = 'my$ecretK3y'
    end
  end

  def teardown
    Timecop.return
    Kagishi.configuration.reset
  end

  def test_issue_token
    issuer = Kagishi::Issuer.new("abc@example.com", payload: { foo: "bar" })
    assert_equal token, issuer.issue_token
  end
end
