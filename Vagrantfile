# frozen_string_literal: true

# -*- mode: ruby -*-
# vi: set ft=ruby :

require_relative 'lib/config'
require_relative 'lib/node'

config_path = ENV.fetch('VAGARI_CONFIG', 'config.yaml')

Vagrant.configure('2') do |vagrant|
  Config.new(config_path).nodes.each do |name, config|
    Node.new(config, name).apply(vagrant.vm)
  end
end
