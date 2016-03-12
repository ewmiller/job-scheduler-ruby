##
# Overall approach:
# Each line of each trace file has specific info about the jobs to simulate.
# I've created a "job" class to represent these. Instances of the job class will
# be declared within processTrace as it iterates through a file's contents.
#
# TODO: implement the actual scheduling part, both RR and FCFS.
# It's not as simple as just having a queue, because we have to account for
# job arrival time. We'll need a queue of all the jobs, a system clock, and a queue
# of jobs that have arrived and are waiting.

require_relative 'job.rb'

class PartOne

  def initialize
  end

  # process an individual trace file
  def fcfs(traceFile, outputFile)
    puts("Analyzing: #{traceFile} in FCFS")

    # read lines of trace file as an array
    traceArr = IO.readlines(traceFile)

    # assign important variables: no. of jobs, simulation time, maximum length
    totalJobs = traceArr[0].to_i
    simTime = traceArr[1].to_i
    maxJobLength = traceArr[2].to_i

    # simulation
    timer = 0
    allJobs = Queue.new

    # for each line in the trace file that describes a job, create job object
    (3..((traceArr.length)-1)).each do |i|
      str = traceArr[i].split(" ")
      allJobs.push(Job.new(str[0], str[1]))
    end

    while(timer < 600) do
      # TODO: change this, it's just to show that the queue works
      if(allJobs.empty?)
        break
      else
        currJob = allJobs.pop
        puts(currJob.getLength)
        timer+=1
      end
    end

  end

  def rr(traceFile, outputFile)
    puts("Analyzing #{traceFile} in RR")
  end

  def main
    File.open("solution.txt", "w") do |outputFile|
      files = Dir.glob("./resources/*.txt")
      files.each do |traceFile|
        fcfs(traceFile, outputFile)
      end
      files.each do |traceFile|
        rr(traceFile, outputFile)
      end
    end
  end # end main

end # end class

p1 = PartOne.new
p1.main
