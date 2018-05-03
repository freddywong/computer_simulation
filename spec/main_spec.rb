require "./app/main"
require 'spec_helper'

describe '#main' do
  it 'prints out values' do
    expect do  
      main
    end.to output("1009\n1010\n").to_stdout
  end 
end