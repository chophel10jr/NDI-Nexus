# frozen_string_literal: true

class CurrentAddress < ApplicationRecord
  belongs_to :verifiable_credential
end
