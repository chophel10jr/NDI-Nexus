# frozen_string_literal: true

class UnsubscribeWebhookService < ApplicationService
  attr_accessor :thread_id, :redis

  def run
    send_post_request(url, body, headers)
  rescue StandardError => e
    Rails.logger.error("Error unsubscribing NDI webhook: #{e.message}")
  end

  private

  def url
    URI.parse(ENV["WEBHOOK_UNSUBSCRIBING_URL"])
  end

  def headers
    {
      "Content-Type" => "application/json",
      "Authorization" => "Bearer #{redis.get('access_token')}"
    }
  end

  def body
    {
      threadId: thread_id
    }
  end
end
