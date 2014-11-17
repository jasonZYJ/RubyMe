RubyMe: A platform for sharing blogs
=======

RubyMe, you know, a platform for sharing blog.
Site url: ****************

## How to Install

Make sure mysql already started.
```bash
git clone git@github.com:jasonZYJ/RubyMe.git
cd RubyMe
# A ruby script to RTF
ruby setup.rb
rails s
```

## How to Test

We use rspec & capybarato test.
```bash
RAILS_ENV=test rails s
# Make sure already installed firefox
bundle exec rspec -fd
```
