# frozen_string_literal: true

require_relative 'component'
require_relative 'node'

class Cluster < BaseComponent
  include BaseComponent::BlockApply

  DSL_NAMESPACE = nil
  DSL_METHOD = :configure

  protected

  def positional
    ['2']
  end

  def configure(target)
    config.fetch(:providers, []).each do |provider_config|
      BaseProvider.for(provider_config).apply(target)
    end

    config.fetch(:networks, []).each do |network_config|
      BaseNetwork.for(network_config).apply(target)
    end

    config.fetch(:provisioners, []).each do |provisioner_config|
      BaseProvisioner.for(provisioner_config).apply(target)
    end

    assign(target.vm, except: %i[nodes providers networks provisioners])

    config.fetch(:nodes, {}).each do |name, node_config|
      Node.new(node_config, name).apply(target)
    end
  end
end
