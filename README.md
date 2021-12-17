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
* If you track your problems and solutions in a Git repository, it is encouraged to add this folder to it.

Project name accepts the following characters:

* Upper and lower case letters.
* Numbers


### General commands

The gem works in general as a CRUD of problems and their properties. Then, sub-commands for the CRUD operations are available.
In general, the structures for that will be the following:

* For problems themselves: `problems [add|remove|show] <problem-name>`.
* For problem listing: `problems list <filters>`.
* For problem properties: `problems [add|edit|remove|list|show] <property> for <problem-name>`.

Not all the sub-commands are going to be available for all the problem properties, those will be detailed in next sections.

### Problems

Actions on problems are described in the table below:

| Action  | Syntax                            | Notes  |
|---------|-----------------------------------|--------|
| add     | `problems add <problem-name>`     | `<problem-name>` accepts the following characters: `[a-zA-Z0-9_-]`.  |
| remove  | `problems remove <problem-name>`  | Will ask for confirmation. Problem and all data are going to be deleted.  |
| list    | `problems list <filters>`         | See a detailed description in [Listing problems](#listing-problems) section.  |
| show    | `problems show <problem-name>`    | Shows the details of a problem.  |

There are reserved words that refer to problem properties and cannot be used as a problem name, and are the following: 
`tag, title, description, url, test, solution`.

### Problem Properties

Properties are edited using the following syntax: `problems <action> <property> for <problem-name>`.
For example, to edit a problem description, the command is `problems edit description for problem-name`.
Available problem properties are edited with the following commands:

| Command                 | Action |
|-------------------------|--------|
| `add tag '#tag'`        | Adds a tag, like a topic, i.e. '#graphs'. Tags should be between quotes and start with #. |
| `remove tag '#tag'`     | Removes a tag. Tags should be between quotes and start with #. |
| `edit title '<title>'`  | Override the formal title of the problem. It could be within double or single quotes.  |
| `edit description`      | Override the description of the problem. It is edited in the console editor using nano.  |
| `edit url <url>`        | Override the problem URL, which can refer to a link or to a coding challenges website.  |
| `remove \[title|description|url\]`  | Removes the property, for example: `problems remove title for problem-name`.  |
| `remove \[title|description|url\] <value>` | Removes the property if and only if it matches the specified value.  |

Values are fully shown with the problems show command: `problems show <problem-name>`.

### Listing problems

Problems can be listed or filtered using the following commands:

| Command                                 | Description |
|-----------------------------------------|-------------|
| `problems list`                         | List all problems.  |
| `problems list by filter1 filter2`      | Filter problems by title or description searching for the specified words.  |
| `problems list by '#tag1' '#tag2' ...`  | Filter problems by multiple tags formatted between quotes and starting with #.  |

Search criteria and tags are compatible to be used together, and they will work as an AND operator.

### Manage test cases

Test cases can be added, edited, listed, viewed and removed for a problem.
When a test case is added, it is assigned with a sequential number, so to edit or remove this number needs to be indicated.
When adding or editing a test case, an editor will be opened and the input and output values should be pasted or typed in the indicated sections.

The base command for this is `problems <action> test for <problem-name>`.
Action list is as follows:

| Actions                 | Description |
|-------------------------|-------------|
| `add`                   | Adds a test case.  |
| `list`                  | List all test cases. The test number will appear in a column.  |
| `show test <test-number>`    | Display the input and expected output of the indicated test case.  |
| `edit test <test-number>`    | Edits the indicated test case.  |
| `remove test <test-number>`  | Removes a test case. Will ask for confirmation. |

### Solutions

Solutions work the same as tests cases: can be added, edited, listed, viewed and removed for a problem.
Also, each one is assigned with a sequential number, so to edit or remove this number needs to be indicated.
When editing a solution, an editor will be opened to edit the code.
By default will lookup for these editors in order: Visual Studio Code and nano.

The base command for this is `problems <action> solution for <problem-name> <extras>`.
Action list is as follows:

| Actions                     | Description |
|-----------------------------|-------------|
| `add`                       | Adds a solution.  |
| `list`                      | List all solutions. Solution number will appear in a column.  |
| `show solution <solution-number>`    | Display the code of the indicated solution.  |
| `edit solution <solution-number>`    | Edits the indicated solution in VS or nano.  |
| `remove solution <solution-number>`  | Removes a solution. Will ask for confirmation.  |

The add command needs an extra configuration to specify the programming language to be used.
Currently, Kotlin, Ruby and Python are supported.
This config is specified appending the following: `with [kotlin|python|ruby]`.

For each solution a folder with a template will be generated. 
The template is a function called `solve` that accepts an array of strings as input and returns a single string.
The input is the test case input splitted in lines, and the output is the program output for each input test case.
Output will be compared with the expected output in the test case.
Internally, the gem will incorporate the code and call the `solve` function with the indicated test cases.

* Kotlin template:

```kotlin
fun solve(lines: List<String>): String {

}
```

* Ruby template:

```ruby
def solve(lines)
end
```

* Python template:

```python
def solve(lines):

```

Additionally, a solution can be run against all or an specific test case, and a problem can be run against all its solutions.
This is done with the special action `run`: 

* Run a problem against all solutions against all test cases: `problems run <problem-name>`.
* Run a problem against all solutions against a test case: `problems run <problem-name> with <test-number>`.
* Run a problem against a solution against all test cases `problems run solution <solution-number> for <problem-name>`.
* Run a problem against a solution against a test case `problems run solution <solution-number> for <problem-name> with <test-number>`.


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/enchf/problems.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
