# Commands Integration Testing

A framework designed to test gem commands through configuration files.

## How it works

CommandsTest class will take all YAML files under `test/integration/suites` and execute the tests for each suite.

## Suite File Structure

Each file have the following structure:

```yaml
name: 'The name of the suite'
tests:     # An array for each of the tests.
  - class: EntityClassName
    actions:
      - name: action    # One of the valid actions defined in Base class.
        args: ['command', 'arguments']   # If not present, an empty array is used.
        expects:        # The expected result from execution.
          property: ''  # A test-defined properties, listed below.
          match: ''     # A regex string to match against.
          value: ''     # An exact value to expect.
    setup:              # Array of commands to be executed before the test
    teardown:           # Array of commands to be executed after the test
    exclude: ['actions', 'to', 'exclude', 'from', 'this', 'test']   # Can be used 'ALL' to exclude the rest of actions.
                                                                    # All the remaining actions will be treated as unimplemented.
```

## Test defined properties

* VERSION: Gem version.
