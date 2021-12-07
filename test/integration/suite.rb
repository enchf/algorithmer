# frozen_string_literal: true

class Suite
  def initialize(config)
    @config = config
  end

  def test
    puts @config['name']
  end
end
