# frozen_string_literal: true

class PermanentAddress < ApplicationRecord
  belongs_to :verifiable_credential
end
