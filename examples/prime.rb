require 'benchmark'
require 'prime'
require '../lib/my_thread_pool'

# This code will find first N primes using 1, 2, 4 and 8 threads.
# Using MRI you shouldn't see any difference, but using JRuby or Rubinius
# you will see the execution becaming faster depending on the number of
# cores of your CPU.

# First N primes
N = 10000

Benchmark.bm do |bm|
  [1, 2, 4, 8].each do |threads|
    bm.report "Using #{threads} thread(s)" do
      thread_pool = MyThreadPool.new(threads)
      N.times do |i|
        thread_pool.perform do
          Prime.prime? i
        end
      end
      thread_pool.join
    end
  end
end