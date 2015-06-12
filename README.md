Rails Debugger Example
======================

A demo app that explores the magic of debuggers.

Setup
=====

* `bundle exec rake db:migrate`

Usage
=====

* Fire up the web server with `bundle exec rails s`
* Visit [http://localhost:3000/foos](http://localhost:3000/foos)
* In the terminal...
  * type `a`     (returns 1)
  * type `@foos` (returns nil)
  * type `break`
  * type `@foos` (returns a collection of Foo objects)

Challenge
=========

Implement stepping through the code, so the following commands work with only one `debug(binding)`, so FoosController#index looks like this...

```
def index
  a = 123
  debug(binding)
  @foos = Foo.all
end
```

... and in the terminal...
* type `a`     (returns 123)
* type `@foos` (returns nil)
* type `step`
* type `@foos` (returns a collection of Foo objects)

License
=======

MIT
