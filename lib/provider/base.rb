# frozen_string_literal: true

require_relative '../component'

class BaseProvider < BaseComponent
  include BaseComponent::BlockApply

  DSL_METHOD = :provider

  def self.for(config)
    super(config, path: __dir__, suffix: 'Provider')
  end
end
