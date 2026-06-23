# frozen_string_literal: true

require 'yaml'

class Context
  attr_reader :config

  def initialize(path = self.class.path)
    raise "Config file doesn't exist" unless File.exist?(path)

    @config = YAML.safe_load_file(path, aliases: true, symbolize_names: true)
  end

  def self.path
    ENV.fetch('VAGARI_CONFIG', File.join(workdir, 'cluster.yaml'))
  end

  def self.workdir
    ENV.fetch('VAGARI_WORKDIR', Dir.pwd)
  end

  def self.resolve(path)
    return path if path.nil?

    File.expand_path(path, workdir)
  end
end
