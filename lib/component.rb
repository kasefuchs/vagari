# frozen_string_literal: true

class BaseComponent
  attr_reader :config

  def initialize(config)
    @config = config
  end

  def self.for(config, path:, suffix:)
    type = config[:type].to_s
    file_path = File.expand_path("#{type}.rb", path)

    if File.exist?(file_path)
      require file_path

      class_name = "#{type.split('_').map(&:capitalize).join}#{suffix}"
      return Object.const_get(class_name).new(config) if Object.const_defined?(class_name)
    end

    new(config)
  end

  module BlockApply
    def apply(target, method: dsl_method, namespace: dsl_namespace)
      receiver = namespace.nil? ? target : target.public_send(namespace)
      receiver.public_send(method, *positional) { |t| configure(t) }
    end
  end

  module OptionsApply
    def apply(target, method: dsl_method, namespace: dsl_namespace)
      receiver = namespace.nil? ? target : target.public_send(namespace)
      receiver.public_send(method, *positional, **options)
    end
  end

  protected

  def positional
    return [@config[:type].to_sym] if @config[:type]

    raise NotImplementedError, "#{self.class} must define #positional or config must include :type"
  end

  %i[DSL_METHOD DSL_NAMESPACE].each do |const|
    define_method(const.to_s.downcase) do
      self.class.const_get(const)
    rescue NameError
      raise NotImplementedError, "#{self.class} must define #{const} constant"
    end
  end

  def configure(target)
    assign(target)
  end

  def options(except: [])
    blacklist = [:type] + except
    @config.reject { |key, _| blacklist.include?(key) }
  end

  def assign(target, except: [])
    options(except: except).each do |key, value|
      target.public_send("#{key}=", value)
    end
  end
end
