# frozen_string_literal: true

require "jwt"

class EncodeTokenService < ApplicationService
  attr_accessor :thread_id

  def run
    secret = ENV["API_KEY"]
    JWT.encode({ thread_id: thread_id }, secret)
  end
end
