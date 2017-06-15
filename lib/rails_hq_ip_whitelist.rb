require "ip_whitelist/controller"
module IPWhitelist
  Configuration = Struct.new(:redirect)

  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

end
