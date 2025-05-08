# frozen_string_literal: true

class Email < ApplicationRecord
  belongs_to :verifiable_credential
end
