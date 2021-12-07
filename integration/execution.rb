# frozen_string_literal: true

class Execution
  BLBL = <<-yaml
  name: 'The name of the suite'
  tests:     # An array for each of the tests.
    - class: EntityClassName
      actions:
        - name: 'name'    # Optional. The name of the test. If not present, the action is used.
          action: action  # One of the valid actions defined in Base class. Can be many tests for each action.
                          # Also, an array of actions can be passed as a batch test.
          args: ''        # Arguments string. If not present, no args are passed.
          expects:        # The expected result from execution.
            property: ''  # A test-defined properties, listed below.
            match: ''     # A regex string to match against.
            value: ''     # An exact value to expect.
            script: ''    # TODO: Executable script of assertions to be run.
      setup:              # TODO: Array of commands to be executed before the test
      teardown:           # TODO: Array of commands to be executed after the test
  yaml
end
