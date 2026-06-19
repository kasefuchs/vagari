# frozen_string_literal: true

require_relative '../component'

class BaseProvisioner < BaseComponent
  def self.for(config)
    super(config, path: __dir__, suffix: 'Provisioner')
  end

  def apply(target, method: :provision)
    target.public_send(method, name) { |p| configure(p) }
  end
end
