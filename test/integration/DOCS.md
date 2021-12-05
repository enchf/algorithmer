# Commands Integration Testing

A framework designed to test gem commands through configuration files.

## How it works

CommandsTest class will take all YAML files under `test/integration/suites` and execute the tests for each suite.

## Suite File Structure

Each file have the following structure:

```yaml
name: 'The name of the suite'
order: 1   # The order in which the file should be executed. Sorted by name on a draw. Optional. If not present executed last.
tests:     # An array for each of the tests.
  - class: EntityClassName
    actions:
      - name: action    # One of the valid actions defined in Base class.
        args: ['command', 'arguments']   # If not present, an empty array is used.
        expects:        # The expected result from execution.
          property: ''  # A test-defined properties, listed below.
          match: ''     # A regex string to match against.
          value: ''     # An exact value to expect.
    exclude: ['actions', 'to', 'exclude', 'from', 'this', 'test']   # Can be used 'ALL' to exclude the rest of actions.
    # All the remaining actions will be treated as unimplemented.
```

## Test defined properties

* VERSION: Gem version.
