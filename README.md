# Grouping

Sample application to do grouping by either phone number or email for entries in CSV file.

Assumptions: If two rows have more that one matching for either email or phone number only the first occurrence of the matching pattern will be considered in grouping rows.

Note: Currently only grouping by either email of phone number are supported

## Usage

In a terminal window, when in projects' root diectory execute the  following command;

```sh
./bin/group <INPUT_CSV> <MATCHING_TYPE [Email|Phone]>
```

**Example** `.bin/group path/to/input.csv Email`

Or you can execute the following Rake task;

```sh
bundle exec rake group[<INPUT_CSV>, <MATCHING_TYPE>]
```

**Example** `bundle exec rake group[path/to/input.csv, Email]`

In the above commands, `MATCHING_TYPE` is a literal that currently only supports `Email` or `Phone`.


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

