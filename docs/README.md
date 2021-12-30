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

## How the handlers are integrated

The `bin/problems` executable calls an ActionFactory to determine the handler of the CLI command.
As mentioned, ActionFactory is built registering the handlers or each of the entities of the gem.
The entities are all elements present such as the project, problems, problem properties, test cases and solutions.

Each handler inherits from a `Base` class, which allows to register actions.

An action is encapsulated into a class called `Action`, which contains:

* The handler class.
* An action symbol referencing a method of the Handler class.
* A set of validations on the arguments of the method.
* An `accept?` method, returning true if the `*args` passed to the method are valid for the action.

```ruby
class Base
  extend Toolcase::Registry

  def self.action(name, &block)
    # Action registering code.
    handler = Action.new(self, name)
    handler.instance_eval(validations)
    handler.instance_eval(&block)
    register handler, id: name, tag: :actions
  end

  def self.validations
    # General validations from the handler class.
  end

  def self.validator(&block)
    # Add a general validator
  end
end

class Version < Base
  action :version do
    empty_args
  end

  def version
    Problems::VERSION
  end
end

class Project < Base
  validator do
    project_folder?
  end

  # more code here ...
end
```

An action can be registered with validators using Toolcase `Registry`.
And also validators are built using the `Toolcase::Registry` module.
A validator is a class working as a tree of validators.
Each validator can have sub-validations, for example, the `arguments` validator:

```ruby
arguments do
  reserved_word :project
  name /^[A-Za-z0-9-_]+$/
end
```

This validator takes the arguments and each of the validators registered on it are applied to each of the arguments in order:
`reserved_word` for the first argument, `name` for the second, and so on.

A validator is also extended as a leaf of a tree, with child validators.

```ruby
class Validator
  def self.name_alias(id)
    @id ||= id
  end

  def valid?(*args)
    # Specific validator code goes here
  end
end

class LeafValidator < Validator
  extend Toolcase::Registry

  # Generic validation operation.
  def valid?(*args)
    validators.all? { |validator| validator.valid?(*args) }
  end

  def validators
    # Registry of validators.
  end
end
```
