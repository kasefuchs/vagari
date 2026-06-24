# frozen_string_literal: true

require_relative '../component'
require_relative '../context'

class BaseSyncedFolder < BaseComponent
  include BaseComponent::OptionsApply

  DSL_NAMESPACE = :vm
  DSL_METHOD = :synced_folder

  def self.for(config)
    super(config, path: __dir__, suffix: 'SyncedFolder')
  end

  protected

  def ignored
    %i[host guest]
  end

  def positional
    [
      Context.resolve(@config.fetch(:host)),
      @config.fetch(:guest)
    ]
  end
end
