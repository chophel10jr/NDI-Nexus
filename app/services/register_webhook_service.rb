# frozen_string_literal: true

class RegisterWebhookService < ApplicationService
  attr_accessor :redis

  def run
    send_post_request(url, body, headers)
  rescue StandardError => e
    Rails.logger.error("Error registering NDI webhook: #{e.message}")
  end

  private

  def url
    URI.parse(ENV["WEBHOOK_REGISTER_URL"])
  end

  def headers
    {
      "Content-Type" => "application/json",
      "Authorization" => "Bearer #{redis.get('access_token')}"
    }
  end

  def body
    {
      webhookId: ENV["WEBHOOK_ID"],
      webhookURL: ENV["WEBHOOK_URL"],
      authentication: {
        type: "OAuth2",
        version: "v2",
        data: {
          token: ENV["WEBHOOK_TOKEN"]
        }
      }
    }
  end
end
