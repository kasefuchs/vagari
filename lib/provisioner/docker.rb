# frozen_string_literal: true

require_relative 'base'

class DockerProvisioner < BaseProvisioner
  NAME = :docker

  protected

  def configure(target)
    config.fetch(:post_install_provision, []).each do |provisioner_config|
      BaseProvisioner.for(provisioner_config).apply(target, method: :post_install_provision)
    end

    config.fetch(:run, {}).each do |name, options|
      target.run(name, **options)
    end

    assign(target, except: %i[post_install_provision run])
  end
end
