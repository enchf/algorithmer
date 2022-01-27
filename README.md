# Problems

**Problems** is created to have an order and keep the track of the programming challenges an enthusiast developer usually do.
It works as a CLI that provides commands to list, classify, run, add solutions and test cases to programming challenges.


## Installation

* Install it as a global gem: `gem install problems`.
* Test the installation running `problems version`. It will display gem version.
* This gem is intended to work as a CLI, but you can add it freely to a project.


## Usage

After installed, this gem is used as a command to create a problem repository and track and manage the problems inside it.


### Initialize

The first step is to create a project.

```sh
problems init project Project
```

* This will create a folder with a folder called `.problems` inside it.
* `.problems` folder holds project data and configuration.
* If the problems and solutions are wanted to be tracked in a Git repository, add this folder to it.

Project name accepts the following characters:

* Upper and lower case letters.
* Numbers.
* Hyphen and Underscore.


### Manage Problems

Problems can be added, visualized and removed.

A problem is added using the `add` action with the problem name:

```sh
add 3N+1
add Minesweeper
```

A problem name accepts the following characters:

* Upper and lower case letters.
* Numbers.
* Plus sign, hyphen and underscore.

The problem details (title, URL, description, tags) can be visualized using `show`:

```sh
show 3N+1
```

A problem can be removed from the project, using `remove`. A confirmation will be prompted:

```sh
remove TestProblem
```


### Listing Problems

Problems can be listed using:

```sh
list
list by filter '#tag' 'text with spaces'
```

* The form without arguments will list all problems in the project.
* It also accepts filters such as text and tags with the form `list by`.
* Text can be a word and be without quotes.
* A tag should be within quotes and starts with the # sign to differentiate them from the text filters.
* Tags can only contain underscore letters.
* Remember to use quotes in tags otherwise bash will interpret them as comments.
* Text can be placed within single or double quotes in order to contain spaces.
* Text is used to lookup in the problem title and description.
* All the filters will work as an AND operator.
* Valid chars in filters are: numbers, upper/lower letters, operators and signs: +-/*._()[]{}.


### Problem Properties

Each problem can have a title, URL and description. To manipulate them, `edit` and `remove` actions are used.
When editing, if the property value is not present, it will be added, otherwise it will be overwritten.

To edit the title, it is specified within quotes:

```sh
edit 3N+1 title '3N + 1'
```

To edit the problem URL, a well-formatted URL is specified:

```sh
edit 3N+1 url http://uva.es/1
```

To edit the problem description, a bash editor (nano, vi) will be opened. The file edited will be stored for it.

```sh
edit 3N+1 description
```

Any of the properties can be removed to reset the value, using the `remove` action:

```sh
remove 3N+1 title
remove 3N+1 url
remove 3N+1 description
```


### Manage Problem Tags

Problems can have tags to help in classifying them. Tags can refer to a programming website or a topic or anything useful.

A tag is added using the `add` action. Tags are not required to use quotes and the # sign for simplicity:

```sh
add tag recursion to 3N+1
```

A tag can also be removed using the `remove` action:

```sh
remove tag acm from 3N+1
```

And finally, tags of a specific problem can be listed using `list`. Tags also are displayed when a problem is visualized using `show`:

```
list 3N+1 tags
```

### Manage test cases

Test cases can be added, edited, listed, viewed and removed for a problem.

When a test case is added, it is assigned with a sequential number, so to edit or remove this number needs to be indicated.
When adding or editing a test case, an editor will be opened to edit both the input and expected output.

A test is added using `add` action:

```sh
add test to 3N+1
```

All tests cases are listed using `list`:

```sh
list tests of 3N+1
```

A specific test can be displayed, edited or removed using `show`, `edit` or `remove`, respectively. 
In these commands the test case number is indicated as displayed in `list`:

```sh
show test # of 3N+1
edit test # of 3N+1
remove test # from 3N+1
```


### Code Solutions

Solutions work the same as tests cases: can be added, edited, listed, viewed and removed for a problem.
Also, each one is assigned with a sequential number, so to edit or remove this number needs to be indicated.

In adition, a programming language should be specified. 
Problems currently support templates for Kotlin, Ruby, Java and Python.

When adding or editing a solution, an editor will be opened to edit the code.
By default will lookup for these editors in order: Visual Studio Code and nano.

A solution is added using the `add` action. Programming language is specified in lower case letters:

```sh
add kotlin solution to 3N+1
```

To list the current solutions of a problem, the `list` action is used:

```sh
list solutions of 3N+1
```

To display, edit or remove a solution, the number of the solution is specified:

```sh
show solution # of 3N+1
edit solution # of 3N+1
remove solution # from 3N+1
```

For each solution a file will be generated from a template. 
The template is a function called `solve` that accepts an array of strings as input and returns a single string.
The input is the test case input splitted in lines, and the output is the program output for each input test case.
Output will be compared with the expected output in the test case.
Internally, the gem will incorporate the code and call the `solve` function with the indicated test cases.

* Kotlin template:

```kotlin
fun solve(lines: List<String>): String {
  ""
}
```

* Ruby template:

```ruby
def solve(lines)
  ""
end
```

* Python template:

```python
def solve(lines):
  return ""
```

* Java template:

```java
public class Solution {
  public String solve(List<String> lines) {
    return "";
  }
}
```

### Running Solutions

Additionally, a solution can be run against all or an specific test case, and a problem can be run against all its solutions.
This is done with the special action `run`: 

```sh
run 3N+1
```

A combination of tests and solutions can be specified:

```sh
run tests 1,2 of 3N+1 
run tests 1,2 of 3N+1 using solutions 1,2
run solutions 1,2 of 3N+1
run solutions 1,2 of 3N+1 using tests 1,2
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

To see full details on how this gem is developed, look at [this article](docs/README.md).


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/enchf/problems.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
