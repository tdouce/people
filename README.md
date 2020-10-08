This is a take home project.

## Directions

### Step 1 

Build a system to parse and sort a set of records.Create a command line app that takes as input a file with a set of records in one of three formats described below, and outputs (to the screen) the set of records sorted in one of three ways.

#### Input

A record consists of the following 5 fields: last name, first name, gender, date of birth and favorite color. The input is 3 files, each containing records stored in a different format. You may generate these files yourself, and you can make certain assumptions if it makes solving your problem easier.

* The pipe-delimited file lists each record as follows

  ```
   LastName | FirstName | Gender | FavoriteColor | DateOfBirth
  ```
* The comma-delimited file looks like this

  ```
   LastName, FirstName, Gender, FavoriteColor, DateOfBirth
  ```
* The space-delimited file looks like this
  ```
   LastName FirstName Gender FavoriteColor DateOfBirth
  ```
  
You may assume that the delimiters (commas, pipes and spaces) do not appear anywhere in the data values themselves. Write a program in a language of your choice to read in records from these files and combine them into a single set of records.

#### Output

Create and display 3 different views of the data you read in:

* Output 1 – sorted by gender (females before males) then by last name ascending.
* Output 2 – sorted by birth date, ascending.
* Output 3 – sorted by last name, descending.

Display dates in the format M/D/YYYY.

### Step 2 - Build a REST API to access your system

Tests for this section are required as well.

Within the same code base, build a standalone REST API with the following endpoints:

* POST /records - Post a single data line in any of the 3 formats supported by your existing code
* GET /records/gender - returns records sorted by gender
* GET /records/birthdate - returns records sorted by birthdate
* GET /records/name - returns records sorted by name

It's your choice how you render the output from these endpoints as long as it well structured data. These endpoints should return JSON.
To keep it simple, don't worry about using a persistent datastore.

## Setup

### Configuration

1. Install ruby 2.6.2
2. `$ bundle install`

### Test Suite

`$ bundle exec rspec spec/`

### Web Server

`$ bundle exec rails s`

### Command Line App

```
bundle exec rake files:aggregate_records[data/records_comma_delimited.txt,data/records_pipe_delimited.txt,data/records_space_delimited.txt]
```

## Considerations for building the app

### Why Rails

Rails has built in support that allows for satisfying all the requirements of the app. Specifically, it is a web framework that
also supports a command line interface. Additionally, I am more proficient with Rails than any alternative.
It's worth noting that Sinatra, a more simplified web framework than Rails, would be an appropriate choice. 
This take home only requires a portion of Rails functionality and so the "API-only" version of Rails is used.  

### Assumptions
 
There were a number of assumptions taken to simplify this app. These are as follows:

#### Data Store

* An in-memory data store is used (as opposed to sqlite, postgres, etc.). The in-memory data store persists data as 
  long as the process lives. Also, the takehome directions hinted at not using a persistent data store. It's worth noting
  that this had implications on the record sorting implementation.
  
#### End Points

* Authentication is not needed
 
#### Data Inputs

 * The strings are always consistently formatted
 * The strings do not have leading/trailing whitespaces
 * The parsed substrings do not have leading/trailing whitespaces
 * The date strings are consistently formatted like 'YYYY-MM-DD'
 * There is no header in the data files or input params to the http endpoints
 * Delimiters (commas, pipes and spaces) do not appear anywhere in the data values themselves.
 * Strings are always consistently ordered like `<Last Name>,<First Name>,<Gender>,<Favorite Color>,<Date Of Birth>`
 * There are only 3 delimiters
 * All inputs are correctly structured and so data validation and exception handling are not implemented
 
#### Record Sorting

 * All records are sorted as arrays because the takehome suggested not using a data store to persist the records
 
#### HTTP Endpoints

 * The `sort` param in `/records/:sort` is always present so there is not need to support a default
 * The `sort` param in `/records/:sort` will always be 'gender' 'birthdate', 'name' (i.e. nothing else)
 * The `sort` param `name` in `/records/name` means to sort by `last_name`
 * The `sort` param `birthdate` `/records/birthdate` means to sort by `date_of_birth`