# frozen_string_literal: true

require_relative 'base'
require_relative '../context'

class ShellProvisioner < BaseProvisioner
  protected

  def ignored
    super + %i[path]
  end

  def configure(target)
    target.path = Context.resolve(config[:path]) if config.key?(:path)
  end
end
