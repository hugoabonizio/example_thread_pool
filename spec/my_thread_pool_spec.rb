require 'spec_helper'

describe MyThreadPool do
#   it 'has a version number' do
#     expect(ExampleThreadPool::VERSION).not_to be nil
#   end

#   it 'does something useful' do
#     expect(false).to eq(true)
#   end
  before do
    @pool = MyThreadPool.new(size: 2)
  end
  
  it 'should perform a task' do
    counter = 1
    @pool.perform do
      counter += 1
    end
    @pool.join
    expect(counter).to eq 2
  end
end
