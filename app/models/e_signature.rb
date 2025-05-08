# frozen_string_literal: true

class ESignature < ApplicationRecord
  belongs_to :verifiable_credential
end
