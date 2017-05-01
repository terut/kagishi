require 'test_helper'

class KagishiTest < Minitest::Test
  class Sample
    include Kagishi
  end

  def test_issue_token
    assert_match /\A[\w\-_]+\.[\w\-_]+\.[\w\-_]+/, Sample.new.issue_token("abc@example.com")
  end

  def test_verify_token
    email = "abc@example.com"
    token = Sample.new.issue_token(email)
    payload = Sample.new.verify_token(token)
    assert_equal email, payload.email
  end

  def test_payload
    email = "abc@example.com"
    token = Sample.new.issue_token(email)
    payload = Sample.new.payload(token)
    assert_equal email, payload.email
  end
end
