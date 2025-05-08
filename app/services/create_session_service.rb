# frozen_string_literal: true

class CreateSessionService < ApplicationService
  def run
    response = send_post_request(url, body, headers)
    if response.status.success?
      update_token(JSON.parse(response.body)["access_token"])
    else
      handle_error(response)
    end
  rescue StandardError => e
    Rails.logger.error("Error Creating NDI session: #{e.message}")
  end

  private

  def url
    URI.parse(ENV["SESSION_URL"])
  end

  def headers
    {
      "Content-Type" => "application/json"
    }
  end

  def body
    {
      client_id: ENV["SESSION_CLIENT_ID"],
      client_secret: ENV["SESSION_CLIENT_SECRET"],
      grant_type: ENV["SESSION_GRANT_TYPE"]
    }
  end

  def update_token(token)
    REDIS.set("access_token", token, ex: 24.hours.to_i)
  end

  def handle_error(response)
    Rails.logger.error("Failed to create NDI session. HTTP Status: #{response.code}, Response: #{response.body}")
  end
end
