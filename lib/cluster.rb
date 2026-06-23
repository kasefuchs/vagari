# frozen_string_literal: true

require_relative 'component'
require_relative 'node'
require_relative 'network/base'
require_relative 'provider/base'
require_relative 'provisioner/base'
require_relative 'synced_folder/base'

class Cluster < BaseComponent
  include BaseComponent::BlockApply

  DSL_NAMESPACE = nil
  DSL_METHOD = :configure

  protected

  def ignored
    super + %i[nodes providers networks provisioners synced_folders]
  end

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

    config.fetch(:synced_folders, []).each do |sync_config|
      BaseSyncedFolder.for(sync_config).apply(target)
    end

    config.fetch(:nodes, {}).each do |name, node_config|
      Node.new(node_config, name).apply(target)
    end
  end
end
