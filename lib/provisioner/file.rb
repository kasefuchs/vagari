# frozen_string_literal: true

require_relative 'base'
require_relative '../context'

class FileProvisioner < BaseProvisioner
  protected

  def ignored
    super + %i[source]
  end

  def configure(target)
    target.source = Context.resolve(config[:source]) if config.key?(:source)
  end
end
