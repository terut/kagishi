require 'time'
require 'jwt'

require_relative 'kagishi/version'
require_relative 'kagishi/configuration'
require_relative 'kagishi/master'
require_relative 'kagishi/payload'

module Kagishi
  def self.issue_token(email, payload: {})
    master.issue_token(email, payload: payload)
  end

  def self.verify_token(token)
    master.verify_token(token)
  end

  def self.payload(token)
    master.payload(token)
  end

  private

    def self.master
      @master ||= Master.new
    end
end
