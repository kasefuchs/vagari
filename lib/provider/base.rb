# frozen_string_literal: true

require_relative '../component'

class BaseProvider < BaseComponent
  def self.for(config)
    super(config, path: __dir__, suffix: 'Provider')
  end

  def apply(target, method: :provider)
    target.public_send(method, name) { |p| configure(p) }
  end
end
