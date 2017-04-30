require 'test_helper'

class KagishiTest < Minitest::Test
  def test_issue_token
    assert_match /\A[\w\-_]+\.[\w\-_]+\.[\w\-_]+/, Kagishi.issue_token("abc@example.com")
  end

  def test_verify_token
    email = "abc@example.com"
    token = Kagishi.issue_token(email)
    payload = Kagishi.verify_token(token)
    assert_equal email, payload["email"]
  end

  def test_payload
    email = "abc@example.com"
    token = Kagishi.issue_token(email)
    payload = Kagishi.payload(token)
    assert_equal email, payload["email"]
  end
end
