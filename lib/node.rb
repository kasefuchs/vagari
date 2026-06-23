# frozen_string_literal: true

require_relative 'component'
require_relative 'network/base'
require_relative 'provider/base'
require_relative 'provisioner/base'
require_relative 'synced_folder/base'

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

  def ignored
    super + %i[providers networks provisioners synced_folders]
  end

  def positional
    [@name.to_s]
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

    config.fetch(:synced_folders, []).each do |sync_config|
      BaseSyncedFolder.for(sync_config).apply(target)
    end
  end
end
