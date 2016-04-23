require 'benchmark'
require 'open-uri'
require '../lib/my_thread_pool'

# Number of request
N = 64
URL = 'http://www.icanhazip.com/'

Benchmark.bm do |bm|
  [1, 2, 4, 8, 16, 32].each do |threads|
    bm.report "Using #{threads} thread(s)" do
      thread_pool = MyThreadPool.new(threads)
      N.times do |i|
        thread_pool.perform do
          open(URL)
        end
      end
      thread_pool.join
    end
  end
end
