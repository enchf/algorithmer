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
handlers are inspected and the actions classified using the `:tags` option:

```ruby
require 'toolcase'

class ActionFactory
  extend Toolcase::Registry

  add Version
  add Project

  default Invalid

  def self.add(entity)
    register entity, tags: entity.actions
  end
end
```

To fetch the correct action according to the parameters, a look-up into the tagged actions is done.
This is done using the Toolcase `find_by` method, which will iterate over the handlers that support that action.
For example, the `Version` handler only supports the `version` action (`problems version`).
If no handler is found, the `Invalid` handler is returned, which prints an error message in the CLI.

```ruby
def self.resolve(action, *args)
  action = action&.to_sym
  return "Action '#{action}' is not defined" unless tags.include?(action)

  find_by(action) { |handler| handler[action].valid?(*args) }.new.send(action, *args)
end
```

## How the handlers are integrated

The `bin/problems` executable calls an ActionFactory to determine the handler of the CLI command.
As mentioned, ActionFactory is built registering the handlers or each of the entities of the gem.
The entities are all elements present such as the project, problems, problem properties, test cases and solutions.

Each handler inherits from the `Entity` class, which register the configuration of each action.
Each action is refered to be a validator, which accepts or not the input arguments.

```ruby
class Version < Base
  action :version

  def version
    Problems::VERSION
  end
end
```

Each action is configured within a block, which invokes method.
Each method refers sequentially to an input argument.

```ruby
action :init do
  reserved_word :project
  format PROJECT_NAME
end
```

A validator is constructed using a Builder class (validations/validator_builder) which produces a plain validator object.
The configurable parameters are:

* A reductor, which can be `and` or `or`, through the `all` and `any` methods respectively.
* The argument provider, which is a lambda that takes the original `*args` input and extracts whats needs to be validated from there.
* The predicate itself, by default always returns true.

```ruby
ValidatorBuilder.new
                .argument_provider(ArgumentProvider.by_index(size))
                .predicate(&predicate)
                .build
```
