# frozen_string_literal: true

class CreateSessionJob < ApplicationJob
  queue_as :default

  def perform(*args)
    CreateSessionService.new.run
  end
end
