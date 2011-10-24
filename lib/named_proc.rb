# encoding: utf-8

# Class for a proc that's got a name
class NamedProc < Proc
  attr_reader :name

  def initialize(name)
    @name = name
    super
  end
  
  # create one from a given proc/lambda object
  def self.create(name, block, lambda = false)
    name = name.to_sym
    # sorry for this ugly hack, is there a better way to lambdafy?
    block = Module.new.send(:define_method, name.to_sym, &block) if lambda
    
    new(name, &block)
  end
  
  # Proxy object to ease named proc initialization
  module Proxy
    Proc = BasicObject.new
    def Proc.method_missing(name, &block)   NamedProc.create(name, block) end

    Lambda = BasicObject.new
    def Lambda.method_missing(name, &block) NamedProc.create(name, block, true) end
  end
  
  # Mixing in low level method "links"
  module Object
    private
  
    # create a proc with name if given
    def proc
      if block_given?
        super
      else
        NamedProc::Proxy::Proc
      end
    end
    
    # same for lambda
    def lambda
      if block_given?
        super
      else
        NamedProc::Proxy::Lambda
      end
    end
  end
  
  ::Object.send :include, NamedProc::Object
end
