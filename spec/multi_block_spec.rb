# encoding: utf-8
require_relative '../lib/multi_block'

describe "Object#blocks" do
  it "returns the MutliBlock constant (for calling [] on it)" do
    expect( blocks ).to be MultiBlock
  end
end

describe "MultiBlock#[]" do
  describe "yield without arguments" do
    it "calls every block and returns array of results" do
      def null
        yield
      end
  
      expect( null(&blocks[
        proc{5},
        proc{6},
      ]) ).to eq [5,6]
    end
  end

  describe "yield with symbol" do
    it "calls the specified proc, other args get passed" do
      def symbol
        yield :success, "Code Brawl!"
      end
    
      expect( symbol(&blocks[
        proc{5},
        proc.success{|e| e.swapcase},
        proc.error{6},
      ]) ).to eq "cODE bRAWL!"
    end
  
    it 'will raise LocalJumpError if proc name is wrong' do
      def wrong_name
        yield :wrong, "Code Brawl!"
      end
    
      expect{
        wrong_name(&blocks[
          proc{5},
          proc.success{|e| e.swapcase},
          proc.error{6},
        ])
      }.to raise_exception(LocalJumpError)
    end
  end

  describe "yield with integer" do
    it "calls the n-th proc, other args get passed" do
      def integer
        yield 2
      end
    
      expect( integer(&blocks[
        proc{5},
        proc.success{|e| e.swapcase},
        proc.error{6},
      ]) ).to eq 6
    end
  end

  describe "yield with array" do
    it "calls all procs, indentified by symbol or integer, other args get passed" do
      def array
        yield [:success, :error], "Code Brawl!"
      end
    
      expect( array(&blocks[
        proc{5},
        proc.success{|e| e.swapcase},
        proc.error{|e| e.downcase},
      ]) ).to eq ["cODE bRAWL!", "code brawl!"]
    end
  end

  describe "yield with hash" do
    it "takes keys as proc names and passes values as proc args" do
      def hash
        yield success: "Code Brawl!", error: [500, "Internal Brawl Error"]
      end
    
      expect( hash(&blocks[
        proc{5},
        proc.success{|e| e.swapcase},
        proc.error{|no, msg| "Error #{no}: #{msg}"},
      ]).sort ).to eq ["Error 500: Internal Brawl Error", "cODE bRAWL!"]
    end
  end
end
