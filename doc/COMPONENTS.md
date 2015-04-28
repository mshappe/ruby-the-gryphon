Modern software is rarely written entirely from scratch. A web application such as this one is generally a synthesis of
many third-party libraries, with original code leveraging the capabilities of those libraries.

The "Ruby on Rails" framework, for example, is itself actually a synthesis of about 33 other libraries ("gems"). A brand
new Rails project will also usually default to having several more gems included, and those gems, plus their dependencies,
bring a brand new project, with no original code in it whatsoever, to about 54 gems!

This project has in turn added quite a few gems that I've found useful from time to time in other projects, with the
upshot being that it uses upward of 157 gems!

All of which is to say that documenting every single dependency of the project would be a considerable task, and that 
anyone who really wants to know can easily peruse the [Gemfile](https://github.com/mshappe/ruby-the-gryphon/blob/master/Gemfile) and
look things up for yourself.

That said, for the sake of anyone coming into the project, I wanted to document some of the major choices, and the
reasons for them. In particular, if you're thinking of contributing, you should understand what the pieces are.

## Framework: [Ruby on Rails](http://rubyonrails.org) version 4.2

There are many frameworks, and many opinions about frameworks in general and specific frameworks in particular. I find
Rails to be an excellent starting point for a large, potentially complex project, and so, that's the basis here.

## Database: [PostgreSQL](http://postgresql.org) version 9.3

At the time of this writing, PostgreSQL is arguably the most "advanced" of the open-source relational databases. On
the high end, it contains many of the features available in commercial databases, often with comparable stability and
performance. On the low end, it's relatively easy to set up and thus, doesn't add a lot of overhead even for simple
systems that don't need the fancy stuff. 

## JavaScript Interpreter: [CoffeeScript](http://coffeescript.org)

While this site is deliberately not heavy on JavaScript (in order to accommodate the widest variety of browsers, including
older browsers), some small amount of JavaScript is almost required, these days, for the smooth functioning of a modern
web application. I choose to write any such code using the altenrative CoffeeScript syntax, which is then processed during
asset compilation into JavaScript. The reason for this is simple aesthetic preference: I think CoffeeScript's syntax
is cleaner, and also more nearly reflects JavaScript's semantics. JavaScript, by itself, too closely resembles languages
I know well (C & C++), while not actually **behaving** like any of them. CoffeeScript allows me to avoid the 
cognitive dissonance!

## View Template Language: [Slim](http://slim-lang.org)

By default, templates in Rails use the Embedded Ruby (ERB) syntax. As a result, they wind up looking like standard HTML
with some bits added. For many people, especially for beginners, this is ERB's strength -- you can write a template
that looks exactly like the HTML you want output, and just insert the logic and values you need using ERB.

The problem is that HTML, by itself, is terribly verbose. Slim, as its name suggests, cuts away much of the verbosity
while still providing most of the capabilities of ERB. As such, all of the view templates for this project are written
using Slim.

## Style sheet baseline: [Twitter Bootstrap](http://getbootstrap.com)

Bootstrap provides a rich set of [CSS](http://en.wikipedia.org/wiki/Cascading_Style_Sheets) styles for defining 
[responsive](http://en.wikipedia.org/wiki/Responsive_web_design)
websites that adapt to a wide range of devices, as well as a clean set of components and some lightweight JavaScript
plugins for enhancing the visual design of as site. All of its stylistic choices can be easily augmented or overridden
using the application's own stylesheets, so it really is just a starting point.

## Authentication: [Devise](http://github.com/plataformatec/devise)

Devise is widely used in the Ruby community to provide the entire gamut of authentication tasks -- registration, confirmation,
password recovery, etc. While we've customized the templates and some of the logic, the bulk of the logic has been done
for us!

## Authorization: [CanCanCan](http://github.com/CanCanCommunity/cancancan) and [Rolify](https://github.com/RolifyCommunity/rolify)

CanCanCan (imagine Harold Zidler from _Moulin Rouge_ saying it) is a continuation of the earlier CanCan project. Both of them
provide a structure and a set of utilities for defining who can, and cannot, access specific resources. For example, I can
say that an administrator can manage any resource; that a user can edit their own profile; that only logged-in users can
search Personas; and that anyone at all can see Events; all in a centralized place (the Ability model) and in a few
clear lines of code.

Rolify allows for flexibly defining roles for users. Used in conjunction with CanCanCan, it allows me to make such
Ability statements as:

```
  if user.has_role? :admin
    can :manage, :all
...
```

or

```
  if user.has_role? :event_officer
    can :manage, Event
...
```