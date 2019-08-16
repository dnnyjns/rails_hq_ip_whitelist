# frozen_string_literal: true

# typed: strict

require "rails"
require "sorbet-runtime"
require "ip_whitelist/config"
require "ip_whitelist/controller"

module IPWhitelist
  extend T::Sig

  @config = T.let(Config.new, Config)
  @redirect = T.let(nil, T.nilable(String))

  sig { returns(Config) }
  def self.config
    @config
  end

  sig { params(block: T.proc.params(config: Config).void).void }
  def self.configure(&block)
    block.call(config)
  end

  sig { returns(T.nilable(String)) }
  def self.redirect
    @redirect ||=
      if config.redirect.is_a?(Proc)
        redirect_proc = T.cast(config.redirect, Proc)
        redirect = T.cast(redirect_proc.call, String)
        T.assert_type!(redirect, String)
      else
        T.cast(config.redirect, T.nilable(String))
      end
  end
end
