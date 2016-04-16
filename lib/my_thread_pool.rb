require "my_thread_pool/version"

class MyThreadPool
  def initialize(size: 2)
    @queue = Queue.new
    @threads = Array.new(size) do
      Thread.new do
        while task = @queue.pop and !task.nil?
          task.call
        end
      end
    end
  end
  
  def perform(&block)
    @queue.push block
  end
  
  def join
    @threads.size.times { @queue.push nil }
    @threads.map(&:join)
  end
end
