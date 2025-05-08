# frozen_string_literal: true

class MobileNumber < ApplicationRecord
  belongs_to :verifiable_credential
end
