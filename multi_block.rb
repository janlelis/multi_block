# encoding: utf-8
require_relative 'named_proc'

module MultiBlock
  # multiple block transformation method,
  # sorry for the method length and the code dup ;)
  def self.[](*proc_array)
    # Create hash representation, proc_array will still get used sometimes
    proc_hash = {}
    proc_array.each{ |proc|
      proc_hash[proc.name] = proc if proc.respond_to?(:name)
    }
    
    # Build yielder proc
    Proc.new{ |*proc_names_and_args|
      if proc_names_and_args.empty? # call all procs
        proc_array.map(&:call)
        
      else
        proc_names, *proc_args = *proc_names_and_args
        
        if proc_names.is_a? Hash # keys: proc_names, values: args
          proc_names.map{ |proc_name, proc_args|
            proc = proc_name.is_a?(Integer) ? proc_array[proc_name] : proc_hash[proc_name.to_sym]
            proc or raise LocalJumpError, "wrong block name given (#{proc_name})"
            
            [proc, Array(proc_args)]
          }.map{ |proc, proc_args|
            proc.call(*proc_args)
          }
          
        else
          ret = Array(proc_names).map{ |proc_name|
            proc = proc_name.is_a?(Integer) ? proc_array[proc_name] : proc_hash[proc_name.to_sym]
            proc or raise LocalJumpError, "wrong block name given (#{proc_name})"
            
            [proc, Array(proc_args)]
          }.map{ |proc, proc_args|
            proc.call(*proc_args)
          }
          
          proc_names.size == 1 ? ret.first : ret  # deliver consistent return value
        end
      end
    }
  end
  
  # low level mixins
  module Object
    private
    
    # to_proc helper, see README
    def blocks
      MultiBlock#[]
    end
    
    # alias procs blocks
    # alias b     blocks
  end
  
  ::Object.send :include, ::MultiBlock::Object

  # Bonus array mixin (if you want to)
  module Array
    # see README for an example
    def to_proc
      ::MultiBlock[*self]
    end
  end
  
  # ::Array.send :include, MultiBlock::Array
end
