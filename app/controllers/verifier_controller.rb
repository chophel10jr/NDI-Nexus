# frozen_string_literal: true

require "rqrcode"

class VerifierController < ApplicationController
  before_action :authenticate_api_key!

  UNAUTHORIZED_ERROR = "Unauthorized access!".freeze
  CONNECTION_ERROR = "Connection error!".freeze

  def create_proof_request
    proof_response = create_proof_request_service
    return render_error_response(proof_response) unless proof_response&.status&.success?

    data = parse_json(proof_response.body).fetch("data", {})
    webhook_response = subscribe_webhook_service(data)
    return render_error_response(webhook_response) unless webhook_response&.status&.success?

    render_success_response(data)
  end

  private

  def authenticate_api_key!
    api_key = request.headers["X-API-KEY"]
    expected_key = ENV["API_KEY"]

    unless ActiveSupport::SecurityUtils.secure_compare(api_key.to_s, expected_key.to_s)
      render json: { error: UNAUTHORIZED_ERROR }, status: :unauthorized
    end
  end

  def create_proof_request_service
    CreateProofRequestService.new(redis: REDIS, attributes: permit_attributes).run
  end

  def subscribe_webhook_service(data)
    SubscribeWebhookService.new(thread_id: data["proofRequestThreadId"], redis: REDIS).run
  end

  def render_error_response(response)
    message = parse_json(response.body).dig("message") || CONNECTION_ERROR
    status = response.status.respond_to?(:to_sym) ? response.status.to_sym : :bad_gateway

    render json: { error: message }, status: status
  end

  def render_success_response(data)
    render json: {
      proof_request_threaded_id: data["proofRequestThreadId"],
      deep_link_url: data["deepLinkURL"],
      proof_request_url: data["proofRequestURL"]
    }, status: :ok
  end

  def parse_json(body)
    JSON.parse(body)
  rescue JSON::ParserError
    {}
  end

  def permit_attributes
    params.require(:attributes).permit!
  end
end
