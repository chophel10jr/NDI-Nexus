# frozen_string_literal: true

class RegisterWebhookJob < ApplicationJob
  queue_as :default

  def perform(*args)
    RegisterWebhookService.new(redis: REDIS).run
  end
end
