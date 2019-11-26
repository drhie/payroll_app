# README

## Requirements
This application is built with the following:
- Ruby v2.5.3
- Rails 6
- PostgreSQL

## Setting Up The Application
In the app's root directory (`payroll_app/`):
1. Install required gems.
```
bundle install
```

2. Create database and run migrations.
```
bundle exec rails db:create
bundle exec rails db:migrate
```

3. Run Rails server. *(If 3000 is taken, use another available port.)*
```
rails s -p 3000 -b 0.0.0.0
```

4. Open application in your browser.
```
http://localhost:3000
```

## Run Tests
In the app's root directory, run the following:
```
rspec spec/
```

## Implementation Thoughts
&nbsp;&nbsp;&nbsp;&nbsp;I implemented this application with an object-oriented design in mind. As with any prototype, it was made with the assumption that the future will cause it to change. As a result, design decisions that don't have to be made now were postponed (such as creating a job, employee or payroll table). Classes and modules were designed to have simple public interfaces. Methods were made with a single responsibility.

&nbsp;&nbsp;&nbsp;&nbsp;The code is intended to be simple and DRY when appropriate. Comments were added when I felt unresolved about a particular decision I made, or felt a need to explain why. Classes were created only when it felt like something was "doing too much". Specs were written with the intent of describing behavior to other developers. This is all to say that, while the code is far from perfect, it aspires to be simple and communicative.
