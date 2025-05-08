# frozen_string_literal: true

class VerifiableCredentialSerializer < ActiveModel::Serializer
  attributes :id, :threaded_id, :shared, :created_at, :updated_at

  has_one :foundational_id
  has_one :permanent_address
  has_one :current_address
  has_one :mobile_number
  has_one :email
  has_one :passport_size_photo
  has_one :e_signature
end
