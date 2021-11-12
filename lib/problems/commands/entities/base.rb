# frozen_string_literal: true

module Commands
  # Base entity class.
  # Define accepted actions and a default behavour for them.
  class Base
    ACTIONS = %i[add edit remove show list init run version].freeze

    ACTIONS.each do |action|
      define_method(action) do
        "Action #{action} is not defined for object #{self.class.name}"
      end
    end

    def initialize(*_); end

    def self.accept?(*_)
      false
    end
  end
end
