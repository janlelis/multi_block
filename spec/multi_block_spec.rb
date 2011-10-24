# encoding: utf-8
require_relative '../lib/multi_block'

describe "blocks" do
  it "returns the MutliBlock constant (for calling [] on it)" do
    blocks.should == MultiBlock
  end
end

describe MultiBlock, "#[]" do
  it "yield without args: calls every block and returns array of results" do
    def null
      yield
    end
  
    null(&blocks[
      proc{5},
      proc{6},
    ]).should == [5,6]
  end
  
  it "yield with symbol: calls the specified proc, other args get passed" do
    def symbol
      yield :success, "Code Brawl!"
    end
    
    symbol(&blocks[
      proc{5},
      proc.success{|e| e.swapcase},
      proc.error{6},
    ]).should == "cODE bRAWL!"
  end
  
  it 'yield with symbol: raises LocalJumpError if proc name is wrong' do
    def wrong_name
      yield :wrong, "Code Brawl!"
    end
    
    proc do
      wrong_name(&blocks[
        proc{5},
        proc.success{|e| e.swapcase},
        proc.error{6},
      ])
    end.should raise_exception(LocalJumpError)
  end
  
  it "yield with integer: calls the n-th proc, other args get passed" do
    def integer
      yield 2
    end
    
    integer(&blocks[
      proc{5},
      proc.success{|e| e.swapcase},
      proc.error{6},
    ]).should == 6
  end
  
  it "yield with array: calls all procs, indentified by symbol or integer, other args get passed" do
    def array
      yield [:success, :error], "Code Brawl!"
    end
    
    array(&blocks[
      proc{5},
      proc.success{|e| e.swapcase},
      proc.error{|e| e.downcase},
    ]).should == ["cODE bRAWL!", "code brawl!"]
  end
  
  it "yield with hash: takes keys as proc names and passes values as proc args" do
    def hash
      yield success: "Code Brawl!", error: [500, "Internal Brawl Error"]
    end
    
    hash(&blocks[
      proc{5},
      proc.success{|e| e.swapcase},
      proc.error{|no, msg| "Error #{no}: #{msg}"},
    ]).sort.should == ["Error 500: Internal Brawl Error", "cODE bRAWL!"]
  end
end
