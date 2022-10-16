# frozen_string_literal: true

module ActiveRecord
  module SecureToken
    original_verbose = $VERBOSE
    $VERBOSE = nil # suppress warnings
    MINIMUM_TOKEN_LENGTH = 6
    $VERBOSE = original_verbose
    #self.class.send(:remove_const, MINIMUM_TOKEN_LENGTH)
    #self.class.const_set(MINIMUM_TOKEN_LENGTH, 6)
  end
end
