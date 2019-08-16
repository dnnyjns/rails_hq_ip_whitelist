# frozen_string_literal: true

# typed: strict

module IPWhitelist
  class Config < T::Struct
    prop :redirect, T.nilable(T.any(String, T.proc.returns(String)))
  end
end
