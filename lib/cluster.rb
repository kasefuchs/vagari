# frozen_string_literal: true

require_relative 'component'
require_relative 'node'

class Cluster < BaseComponent
  include BaseComponent::BlockApply

  NAME = '2'
  DSL_METHOD = :configure

  protected

  def configure(target)
    machine = target.vm

    config.fetch(:providers, []).each do |provider_config|
      BaseProvider.for(provider_config).apply(machine)
    end

    config.fetch(:networks, []).each do |network_config|
      BaseNetwork.for(network_config).apply(machine)
    end

    config.fetch(:provisioners, []).each do |provisioner_config|
      BaseProvisioner.for(provisioner_config).apply(machine)
    end

    assign(machine, except: %i[nodes providers networks provisioners])

    config.fetch(:nodes, {}).each do |name, node_config|
      Node.new(node_config, name).apply(machine)
    end
  end
end
