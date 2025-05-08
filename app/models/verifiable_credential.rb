# frozen_string_literal: true

class VerifiableCredential < ApplicationRecord
  has_one :foundational_id, dependent: :destroy
  has_one :permanent_address, dependent: :destroy
  has_one :current_address, dependent: :destroy
  has_one :mobile_number, dependent: :destroy
  has_one :email, dependent: :destroy
  has_one :passport_size_photo, dependent: :destroy
  has_one :e_signature, dependent: :destroy

  validates :threaded_id, uniqueness: true
end
