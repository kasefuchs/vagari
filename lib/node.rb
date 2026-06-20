# frozen_string_literal: true

require_relative 'component'
require_relative 'network/base'
require_relative 'provider/base'
require_relative 'provisioner/base'

class Node < BaseComponent
  include BaseComponent::BlockApply

  DSL_NAMESPACE = :vm
  DSL_METHOD = :define

  attr_reader :name

  def initialize(config, name)
    super(config)
    @name = name
  end

  protected

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

    assign(target.vm, except: %i[providers networks provisioners])
  end
end
