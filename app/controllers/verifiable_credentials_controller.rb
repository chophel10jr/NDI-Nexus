# frozen_string_literal: true

class VerifiableCredentialsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [ :create ]

  def create
    vc = VerifiableCredential.create(threaded_id: params["thid"])
    if params["type"] == "present-proof/presentation-result"
      CreateDependentCredentialsService.new(vc_id: vc.id, params: permitted_vc_params).run
      vc.update(shared: true)
    end

    render plain: "Accepted", status: 202
  end

  def fetch
    return render json: { error: "Missing or empty token" }, status: :bad_request if params[:token].blank?

    threaded_id = decode_token(params[:token])
    return render json: { error: "Invalid or expired token" }, status: :unauthorized unless threaded_id

    vc = VerifiableCredential.find_by(threaded_id: threaded_id)
    return render json: { error: "Verifiable Credential not found" }, status: :not_found unless vc

    render json: vc, serializer: VerifiableCredentialSerializer, status: :ok
  end

  private

  def decode_token(token)
    DecodeTokenService.new(token: token).run
  rescue StandardError
    nil
  end

  def permitted_vc_params
    params.permit(:type, :thid, requested_presentation: {
      revealed_attrs: {},
      self_attested_attrs: {}
    })
  end
end
