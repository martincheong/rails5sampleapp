# README

This a sample application created with the help of:
[*Ruby on Rails Tutorial*: Learn Web Development with Rails(http://www.railstutorial.org)]
by [Michael Hartl](http://www.michaelhartl.com/).

# Differences from Michael Hartl's Tutorial

## SimpleCov
I'm Experimenting/Learning with SimpleCov https://github.com/colszowka/simplecov
to track test coverage of the code.
Settings is relation to SimpleCov is guided by https://medium.com/@heidar/how-i-test-rails-apps-with-minitest-capybara-and-guard-5e07a6856781#.u2qlnwwl8

# Chapter 5
### Ex1 & 2 (cat image..) are skipped

# Chapter 9
## 2nd subtle bug
To observe the subtle bug (logged in on 2 browsers), edit settings in chrome as
[link follows]
(http://stackoverflow.com/questions/10617954/chrome-doesnt-delete-session-cookies)
If not clear the session manually in the inspector
## Getting started

To get started with the app, clone the repo and then install the needed gems:

```
$ bundle install --without production
```

Next, migrate the database:

```
$ rails db:migrate
```

Finally, run the test suite to verify that everything is working correctly:

```
$ rails test
```

If the test suite passes, you'll be ready to run the app in a local server:

```
$ rails server
```

For more information, see the
[*Ruby on Rails Tutorial* book](http://www.railstutorial.org/book).
