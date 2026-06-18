# frozen_string_literal: true

# -*- mode: ruby -*-
# vi: set ft=ruby :

require_relative 'lib/config'
require_relative 'lib/node'

Vagrant.configure('2') do |vagrant|
  Config.new.nodes.each do |name, config|
    Node.new(config, name).apply(vagrant)
  end
end
