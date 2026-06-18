# frozen_string_literal: true

require_relative '../component'

class BaseNetwork < BaseComponent
  def self.for(config)
    super(config, path: __dir__, suffix: 'Network')
  end

  def apply(machine)
    machine.vm.network(name, **options)
  end
end
