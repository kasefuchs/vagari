# frozen_string_literal: true

require_relative '../component'

class BaseNetwork < BaseComponent
  include BaseComponent::OptionsApply

  DSL_NAMESPACE = :vm
  DSL_METHOD = :network

  def self.for(config)
    super(config, path: __dir__, suffix: 'Network')
  end
end
