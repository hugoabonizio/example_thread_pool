require 'benchmark'
require '../lib/my_thread_pool'

# Number of request
N = 32

Benchmark.bm do |bm|
  # This should take 32, 16, 8 and 4 seconds
  [1, 2, 4, 8].each do |threads|
    bm.report "Using #{threads} thread(s)" do
      thread_pool = MyThreadPool.new(threads)
      N.times do |i|
        thread_pool.perform do
          # Emulate a 1 second waiting task
          sleep 1
        end
      end
      thread_pool.join
    end
  end
end