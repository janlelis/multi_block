module MultiBlock
  # Multiple block transformation method
  def self.[](*proc_array)
    # Create hash representation, proc_array will still get used sometimes
    proc_hash = {}
    proc_array.each{ |proc|
      proc_hash[proc.name] = proc if proc.respond_to?(:name)
    }
    
    # Build yielder proc
    Proc.new{ |*proc_names_and_args|
      if proc_names_and_args.empty? # call all procs
        ret = proc_array.map(&:call)
        
        proc_array.size == 1 ? ret.first : ret
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

          ret.size == 1 ? ret.first : ret
          
        end
      end
    }
  end
  
  # Low level mixins
  module Object
    private
    
    def blocks
      MultiBlock#[]
    end
  end

  # Optional Array mixin, use it with
  # ::Array.include MultiBlock::Array
  module Array
    def to_proc
      ::MultiBlock[*self]
    end 
  end 
end
