# How this gem is developed

This gem has been created in a particular way of development.
Mainly it is supported by the [Toolcase gem](https://github.com/enchf/toolcase).
This gem works as a registerable container:
An object can be registered in the class and later used or fetched according to certain conditions.

## Toolcase features used

Toolcase is applied to create factories to handle gem commands.
For example, the `register` method is used to add handlers to the ActionFactory:

```ruby
require 'toolcase'

class ActionFactory
  extend Toolcase::Registry

  register Version
  register Project

  default Invalid
end
```

The `default` method is used to register a handler which will be returned if no handler is available.
For example, when an invalid action is being executed.

Moreover, as each entity (projects, problems, properties, etc.) has different actions registered,
handlers are inspected and the actions classified using the `:tag` option:

```ruby
require 'toolcase'

class ActionFactory
  extend Toolcase::Registry

  add Version
  add Project

  default Invalid

  def self.add(handler)
    handler.actions.each do |action|
      register action, tag: action.name
    end
  end
end
```

To fetch the correct action according to the parameters, a look-up into the tagged actions is done.
This is done using the Toolcase `find_by` method, which will iterate over the handlers that support that action.
For example, the `Version` handler only supports the `version` action (`problems version`).
If no handler is found, the `Invalid` handler is returned, which prints an error message in the CLI.

```ruby
def self.resolve(action, *args)
  find_by(action) { |handler| handler.accept?(*args) }
end
```
