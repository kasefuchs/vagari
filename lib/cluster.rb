# frozen_string_literal: true

require_relative 'component'
require_relative 'node'

class Cluster < BaseComponent
  include BaseComponent::BlockApply

  NAME = '2'
  DSL_METHOD = :configure

  protected

  def configure(target)
    config.fetch(:nodes, {}).each do |name, node_config|
      Node.new(node_config, name).apply(target.vm)
    end
  end
end
