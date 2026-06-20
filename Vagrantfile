# frozen_string_literal: true

# -*- mode: ruby -*-
# vi: set ft=ruby :

require_relative 'lib/config'
require_relative 'lib/cluster'

config_path = ENV.fetch('VAGARI_CONFIG', 'config.yaml')

config = Config.new(config_path)

Cluster.new(config.data).apply(Vagrant)
