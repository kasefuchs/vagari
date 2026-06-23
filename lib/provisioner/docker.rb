# frozen_string_literal: true

require_relative 'base'

class DockerProvisioner < BaseProvisioner
  NAME = :docker

  protected

  def ignored
    super + %i[post_install_provision run]
  end

  def configure(target)
    config.fetch(:post_install_provision, []).each do |provisioner_config|
      BaseProvisioner.for(provisioner_config).apply(target, method: :post_install_provision, namespace: nil)
    end

    config.fetch(:run, {}).each do |name, options|
      target.run(name, **options)
    end
  end
end
