# frozen_string_literal: true

require 'test_helper'
require 'problems/commands/entities/project'

class ProjectTest < Minitest::Test
  def test_refuted_args
    refute tested_class.accept?('project')
    refute tested_class.accept?('project', 'invalid@name')
    refute tested_class.accept?
  end

  def test_accepted_args
    assert tested_class.accept?('project', 'projectName_-01')
  end

  def tested_class
    ::Commands::Project
  end
end
