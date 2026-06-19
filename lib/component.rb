# frozen_string_literal: true

class BaseComponent
  attr_reader :config

  def initialize(config)
    @config = config
  end

  def self.for(config, path:, suffix:)
    kind = config[:kind]
    file_path = File.expand_path("#{kind}.rb", path)

    raise "Module for '#{kind}' doesn't exist" unless File.exist?(file_path)

    require file_path

    class_name = "#{kind.split('_').map(&:capitalize).join}#{suffix}"
    raise "Class '#{class_name}' not defined" unless Object.const_defined?(class_name)

    Object.const_get(class_name).new(config)
  end

  def name
    self.class::NAME
  rescue NameError
    raise NotImplementedError, "#{self.class} must define NAME constant"
  end

  def dsl_method
    self.class::DSL_METHOD
  rescue NameError
    raise NotImplementedError, "#{self.class} must define DSL_METHOD constant"
  end

  module BlockApply
    def apply(target, method: dsl_method)
      target.public_send(method, name) { |t| configure(t) }
    end
  end

  module OptionsApply
    def apply(target, method: dsl_method)
      target.public_send(method, name, **options)
    end
  end

  protected

  def configure(target)
    assign(target)
  end

  def options(except: [])
    blacklist = [:kind] + except

    @config.reject { |key, _| blacklist.include?(key) }
  end

  def assign(target, except: [])
    options(except: except).each do |key, value|
      target.public_send("#{key}=", value)
    end
  end
end
