# frozen_string_literal: true

class CreateProofRequestService < ApplicationService
  attr_accessor :redis, :attributes

  MAX_RETRIES = 3
  RETRY_DELAY = 2

  def run
    attempt = 0

    begin
      attempt += 1

      response = send_post_request(url, body, headers)

      return response if response.status.success?

      raise "Unsuccessful response: #{response.status}"
    rescue StandardError => e
      log_retry_error(attempt, e)
      retry if attempt < MAX_RETRIES
    end

    response
  end

  private

  def url
    URI.parse(ENV["PROOF_REQUEST_URL"])
  end

  def headers
    {
      "Content-Type" => "application/json",
      "Authorization" => "Bearer #{redis.get('access_token')}"
    }
  end

  def body
    {
      proofName: "Verify Foundational ID",
      proofAttributes: format_proof_attributes
    }
  end

  def format_proof_attributes
    proof_attributes = []

    attributes.each do |attribute_type, fields|
      fields.each do |field_name|
        proof_attributes << {
          name: field_name,
          restrictions: [
            { schema_name: schema_name_for(attribute_type) }
          ]
        }
      end
    end

    proof_attributes
  end

  def schema_name_for(attribute_type)
    {
      "Foundational ID" => ENV["FOUNDATIONAL_ID_SCHEMA_ID"],
      "Permanent Address" => ENV["PERMANENT_ADDRESS_SCHEMA_ID"],
      "Current Address" => ENV["CURRENT_ADDRESS_SCHEMA_ID"],
      "Mobile Number" => ENV["MOBILE_NUMBER_SCHEMA_ID"],
      "Email" => ENV["EMAIL_SCHEMA_ID"],
      "Passport-Size Photo" => ENV["PASSPORT_SIZE_PHOTO_SCHEMA_ID"]
    }[attribute_type]
  end

  def log_retry_error(attempt, error)
    Rails.logger.error("Attempt #{attempt}/#{MAX_RETRIES} failed: #{error.message}")
    sleep RETRY_DELAY
  end
end
