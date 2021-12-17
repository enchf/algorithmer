# Refactor details

New specification:

```sh
version

init project ACM

add 3N+1
add Minesweeper
show 3N+1
remove TestProblem

list
list by ‘filter’ ‘#tag’

edit 3N+1 title ‘3N + 1’
edit 3N+1 url http://uva.es/1
edit 3N+1 description

remove 3N+1 title
remove 3N+1 url
remove 3N+1 description

add tag recursion to 3N+1
remove tag acm from 3N+1
list 3N+1 tags

add test to 3N+1
list tests of 3N+1
show test # of 3N+1
edit test # of 3N+1
remove test # from 3N+1

add kotlin solution to 3N+1
list solutions of 3N+1
show solution # of 3N+1
edit solution # of 3N+1
remove solution # from 3N+1

run 3N+1 
run tests 1,2 of 3N+1 
run tests 1,2 of 3N+1 using solutions 1,2
run solutions 1,2 of 3N+1
run solutions 1,2 of 3N+1 using tests 1,2
```

Preview of the CLI:

```ruby
class Factory
  extend Toolcase::Registry

  add Version
  add Project
  add Problem
  add Tag
  add Description
  add URL
  add Title
  add Filter
  add Test
  add Solution

  default Unknown

  def self.add(entity)
    entity.actions.each do |name, action|
      register action, registry: name
    end
  end

  def self.resolve(action, *args)
    find_by(action, *args).execute(*args)
  end
end

class Base
  extend Toolcase::Registry

  alias :actions, :registry

  def self.action(name, &block)
    handler = Action.new(self, name)
    handler.instance_eval(validations)
    handler.instance_eval(&block)
    register handler, as: name
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
  extend Parentable

  descriptor :name

  validator do
    project_folder?
  end

  action :init do
    arguments do
      reserved_word :project
      name /^[A-Za-z0-9]+$/
    end
  end

  def init(name)
    "Create folder called #{name} for Project #{name}"
  end

  def name
    "Find project name in .problems config"
  end
end

class Problem < Base
  extend Parentable
  
  descriptor :id

  validator :problem_validator do
    format Formats::PROBLEM
    problem_exists?
  end

  parent Project

  actions :add, :show, :remove do
    arguments do
      format /^[A-Za-z0-9+-_]+$/, as: :name
    end
  end

  # run 3N+1 
  action :run
    arguments do
      problem_validator
    end
  end

  def add(problem)
    "Problem #{problem} added to project #{project.name}"
  end

  def show(problem)
    "Show problem #{problem} details"
  end

  def remove(problem)
    "Problem #{problem} removed from project #{project.name}"
  end

  def run(problem)
    "All solutions for problem #{problem} executed against all test cases"
  end

  def id
    "Find problem id in .problems config"
  end
end

class Filter < Base
  parent Project

  action :list do
    or do
      empty_args
      arguments do
        reserved_word :by
        varargs do
          or do
            format Formats::HASHTAG
            format Formats::NAME
          end
        end
      end
    end
  end

  def list(*filters)
    prefix = filters.empty? ? 'List all' : "Filters #{filters.join(", ")} applied to list"
    "#{prefix} problems from project #{project.name}"
  end
end

class Title < Base
  parent Problem

  action :edit do
    arguments do
      problem_validator
      reserved_word :title
      format Formats::TITLE
    end
  end

  action :remove do
    arguments do
      problem_validator
      reserved_word :title
    end
  end

  def edit(problem, title)
    "Edit problem #{problem} title as #{title}"
  end

  def remove(problem)
    "Remove problem #{problem} title"
  end
end

class URL < Base
  parent Problem

  action :edit do
    arguments do
      problem_validator
      reserved_word :url
      format Formats::URL
    end
  end

  action :remove do
    arguments do
      problem_validator
      reserved_word :url
    end
  end

  def edit(problem, url)
    "Edit problem #{problem} URL as #{url}"
  end

  def remove(problem)
    "Remove problem #{problem} title"
  end
end

class Description < Base
  parent Problem

  actions :edit, :remove do
    arguments do
      problem_validator
      reserved_word :description
    end
  end

  def edit(problem)
    "Opens an editor to edit problem #{problem} description"
  end

  def remove(problem)
    "Removes problem #{problem} description"
  end
end

class Tag < Base
  parent Problem

  action :add do
    arguments do
      reserved_word :tag
      format Formats::TAG
      reserved_word :to
      problem_validator
    end
  end

  action :remove do
    arguments do
      reserved_word :tag
      format Formats::TAG
      reserved_word :from
      problem_validator
    end
  end

  action :list do
    arguments do
      problem_validator
      reserved_word :tags
    end
  end

  def add(tag, problem)
    "Add tag ##{tag} to problem #{problem}"
  end

  def remove(tag, problem)
    "Remove tag ##{tag} from problem #{problem} if present"    
  end

  def list(problem)
    "List all tags of problem #{problem}"
  end
end

class Test < Base
  parent Problem

  action :add do
    arguments do
      reserved_word :test
      reserved_word :to
      problem_validator
    end
  end

  action :list do
    arguments do
      reserved_word :tests
      reserved_word :of
      problem_validator
    end
  end

  actions :show, :edit do
    arguments do
      reserved_word :test
      valid_index :test
      reserved_word :of
      problem_validator
    end
  end

  action :remove do
    arguments do
      reserved_word :test
      valid_index :test
      reserved_word :from
      problem_validator
    end
  end


  # run tests 1,2 of 3N+1 
  # run tests 1,2 of 3N+1 using solutions 1,2
  action :run do
    arguments do
      reserved_word :tests
      valid_index_list :test
      reserved_word :of
      problem_validator
      optional { reserved_word :using }
      optional { reserved_word :solutions }
      optional { valid_index_list :solution }
    end
  end
end

class Solution < Base
  parent Problem

  action :add do
    arguments do
      programming_language
      reserved_word :solution
      reserved_word :to
      problem_validator
    end
  end

  action :list do
    arguments do
      reserved_word :solutions
      reserved_word :of
      problem_validator
    end
  end

  actions :show, :edit do
    arguments do
      reserved_word :solution
      valid_index :solution
      reserved_word :of
      problem_validator
    end
  end

  action :remove do
    arguments do
      reserved_word :solution
      valid_index :solution
      reserved_word :from
      problem_validator
    end
  end

  # run solutions 1,2 of 3N+1
  # run solutions 1,2 of 3N+1 using tests 1,2
  action :run do
    arguments do
      reserved_word :solutions
      valid_index_list :solution
      reserved_word :of
      problem_validator
      optional { reserved_word :using }
      optional { reserved_word :tests }
      optional { valid_index_list :test }
    end
  end
end
```
