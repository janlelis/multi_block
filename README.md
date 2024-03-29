# MultiBlock [<img src="https://badge.fury.io/rb/multi_block.svg" />](https://badge.fury.io/rb/multi_block) [<img src="https://github.com/janlelis/multi_block/workflows/Test/badge.svg" />](https://github.com/janlelis/multi_block/actions?query=workflow%3ATest)

MultiBlock is a mini framework for passing multiple blocks to methods. It uses [named procs](https://github.com/janlelis/named_proc) to accomplish this with a simple syntax. The receiving method can either yield all blocks, or just call specific ones, identified by order or name.

Currently supports CRuby only.

## Setup

Add to Gemfile:

    gem 'multi_block'


## Usage
### Defining methods that use multiple blocks

The first argument given to yield always defines the desired block(s). The other arguments get directly passed to the block(s):

    yield                                            # calls all given procs without args
    yield :success                                   # calls :success proc without args
    yield :success, "Code Brawl!"                    # calls :success proc with message
    yield 1                                          # calls first proc (:success in this case)
    yield [:success, :bonus]                         # calls :success and :bonus without args
    yield [:success, :bonus], "Code Brawl!"          # calls both procs with same arg
    yield success: "Code Brawl!",                    # calls each keyed proc,
          error:   [500, "Internal Brawl Error"]     #       values are the args


### Calling methods with multiple blocks

Consider these two example methods:

    # calls the :success block if everything worked well
    def ajax
      yield rand(6) != 0 ? :success : :error
    end

    # calls the n-th block
    def dice
      random_number = rand(6)
      yield random_number, random_number + 1
    end


Multiple blocks can be passed using `blocks`:

    ajax &blocks[
      proc.success{ puts "Yeah!"    },
      proc.error  { puts "Error..." },
    ]


The dice method could, for example, be called in this way:

    dice &blocks[
      proc{ ":(" },
      proc{ ":/" },
      proc{ ":O" },
      proc{ ":b" },
      proc{ ":P" },
      proc{ rand(42) != 0 ? ":)"  : ":D"},
    ]


## Bonus sugar: Array extension

If you like the slim `&to_proc` operator, you can further optimize the syntax by activating the core extension for array:

    require 'multi_block/array'

Now you do not need the `blocks` helper anymore. Instead just do:

    do_something, some_argument, &[
      proc.easy_way{
        # do it the easy way
      },
      proc.complex_way{
        # use complex heuristics, etc.
      },
    ]


## MIT License

See the original gist: https://gist.github.com/4b2f5fd0b45118e46d0f
