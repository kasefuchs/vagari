# frozen_string_literal: true

require_relative '../component'

class BaseProvisioner < BaseComponent
  include BaseComponent::BlockApply

  DSL_NAMESPACE = :vm
  DSL_METHOD = :provision

  def self.for(config)
    super(config, path: __dir__, suffix: 'Provisioner')
  end
end
