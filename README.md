# BindingOfCallers

Something like [binding_of_caller](https://github.com/banister/binding_of_caller "binding_of_caller"), but collect all binding of callers at once, and provide convenient methods to inject variable or code in bindings

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'binding_of_callers'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install binding_of_callers

## Usage

```ruby
binding.of_callers # => an array of wrapped binding of callers
binding.of_callers! # => an array of extended binding of callers

binding.partial_callers(4) # => get closest four frames
binding.partial_callers(-2) # => get frames excluding the bottom two
```

### Inspect and modify a binding

```ruby
require 'binding_of_callers'

class Test
  def a
    var, @ivar, arr = 1, 2, []
    b
    p var, @ivar
    p arr
  end

  def b
    c
  end

  def c
    a_bind = binding.of_callers![2]
    p a_bind
    p a_bind.iv, a_bind.lv

    a_bind.lv :var, 'hello'
    a_bind.iv :@ivar, 'world'
    a_bind.lv(:arr) << 'bye' << 'world'
  end
end

Test.new.a

# OUTPUT
#  #<Binding:78145200 Test#a test.rb:6>
#  {:@ivar=>2}
#  {:var=>1, :arr=>[]}
#  "hello"
#  "world"
#  ["bye", "world"]
```

### Work with pry, get binding of callers from `_bs_` or `_bsi_`(with index)

```ruby
require 'binding_of_callers/pry'

class Test
  def a
    var, @ivar, arr = 1, 2, []
    b
    p var, @ivar
    p arr
  end

  def b
    c
  end

  def c
    binding.pry
  end
end

Test.new.a

# IN PRY
#  From: /tmp/test_pry.rb @ line 16 Test#c:
#
#      15: def c
#   => 16:   binding.pry
#      17: end
#
#  [1] pry(#<Test>)> _bs_
#  [#<Binding:76752040 Test#c test_pry.rb:16>,
#   #<Binding:76751000 Test#b test_pry.rb:12>,
#   #<Binding:76734010 Test#a test_pry.rb:6>,
#   #<Binding:76732930 Object#<main> test_pry.rb:20>]
```

