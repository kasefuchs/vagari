# frozen_string_literal: true

require_relative '../component'

class BaseNetwork < BaseComponent
  def self.for(config)
    super(config, path: __dir__, suffix: 'Network')
  end

  def apply(target, method: :network)
    target.public_send(method, name, **options)
  end
end
