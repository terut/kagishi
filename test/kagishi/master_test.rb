require 'test_helper'

class Kagishi::MasterTest < Minitest::Test
  attr_reader :token

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
    assert_equal token, master.issue_token("abc@example.com", payload: { foo: "bar" })
  end

  def test_verify_token
    payload = { email: "abc@example.com", foo: "bar", exp: 1488392100 }
    assert_equal payload, master.verify_token(token).raw
  end

  def test_verify_token_expired
    Kagishi.configure do |config|
      config.ttl = -1
    end
    token = master.issue_token("abc@example.com", payload: { foo: "bar" })
    assert_nil master.verify_token(token)
    Kagishi.configuration.reset
  end

  def test_payload
    payload = { email: "abc@example.com", foo: "bar", exp: 1488392100 }
    assert_equal payload, master.payload(token).raw
  end

  def test_payload_expired
    Kagishi.configure do |config|
      config.ttl = -1
    end
    payload = { email: "abc@example.com", exp: 1488391199 }
    token = master.issue_token("abc@example.com")
    assert_equal payload, master.payload(token).raw
    Kagishi.configuration.reset
  end

  private

    def master
      @master ||= Kagishi::Master.new
    end
end
