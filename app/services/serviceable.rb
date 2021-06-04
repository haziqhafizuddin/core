# frozen_string_literal: true

module Serviceable
  extend ActiveSupport::Concern

  class_methods do
    def call(*args)
      new(*args).call
    end
  end

  def fail(error)
    OpenStruct.new(success?: false, response: { error: error }, error: error)
  end

  def success(args = {})
    OpenStruct.new(success?: true, response: args)
  end

  class Error < StandardError
  end
end
