require "ip_whitelist/controller"
module IPWhitelist

  def self.config
    @config ||= ::ActiveSupport::OrderedOptions.new
  end

  def self.configure(&block)
    config.instance_eval(&block)
  end

  def self.redirect
    @redirect ||=
      if config.redirect.is_a?(Proc)
        config.redirect.call
      else
        config.redirect
      end
  end

end
