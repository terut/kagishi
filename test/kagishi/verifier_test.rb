require 'test_helper'

class Kagishi::VerifierTest < Minitest::Test
  attr_reader :token, :payload, :current_time

  def setup
    @current_time = Time.parse("2017-03-01T18:00:00Z").utc
    Timecop.freeze(current_time)
    Kagishi.configure do |config|
      config.secret = 'my$ecretK3y'
    end

    @token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJmb28iOiJiYXIiLCJlbWFpbCI6ImFiY0BleGFtcGxlLmNvbSIsImV4cCI6MTQ4ODM5MjEwMH0.qObgICrz3rRiNng1c3GQ1Qu1wxZsBXKMbOAVhfz0sGQ"
    @payload = { email: "abc@example.com", foo: "bar", exp: 1488392100 }
  end

  def teardown
    Timecop.return
    Kagishi.configuration.reset
  end

  def test_verify_token
    assert_equal payload, verifier.verify_token.raw
    Timecop.freeze(current_time + Kagishi.configuration.ttl - 1) do
      assert_equal payload, verifier.verify_token.raw
    end
  end

  def test_verify_token_expired
    Timecop.freeze(current_time + Kagishi.configuration.ttl) do
      assert_nil verifier.verify_token
    end
  end

  def test_payload
    assert_equal payload, verifier.payload.raw
    Timecop.freeze(current_time + Kagishi.configuration.ttl + verifier.send(:exp_leeway) - 1) do
      assert_equal payload, verifier.payload.raw
    end
  end

  def test_payload_expired
    Timecop.freeze(current_time + Kagishi.configuration.ttl + verifier.send(:exp_leeway)) do
      assert_nil verifier.payload
    end
  end

  private

    def verifier
      Kagishi::Verifier.new(token)
    end
end
