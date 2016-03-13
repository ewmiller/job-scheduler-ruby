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

  # perform operations on currently queued jobs
  def timeStep(jobQueue)
    if(jobQueue.empty?)
      return
    else
      # increment the job in the front of the line. Add to wait time of others
      jobQueue[0].increment
      (1..((jobQueue.length) -1)).each do |i|
        jobQueue[i].wait
      end
    end
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

    # set variables for simulation
    timer = 0
    allJobs = Array.new
    currJobs = Array.new
    finishedJobs = Array.new

    # for each line in the trace file that describes a job, create job object
    (3..((traceArr.length)-1)).each do |i|
      str = traceArr[i].split(" ")
      allJobs.push(Job.new(str[0], str[1]))
    end

    # TODO: this.
    while(timer <= simTime) do

      # take the next job from the allJobs queue if necessary
      unless allJobs.empty?
        nextTime = allJobs[0].getStartTime

        # TODO: for some reason, this condition isn't being met, so no jobs
        # get queued. 
        if(nextTime == timer)
          puts("Current time: #{timer}")
          puts("Adding job to currJobs: #{allJobs[0]}")
          currJobs.push(allJobs.shift)
        end
      end

      unless currJobs.empty?
        if(currJobs[0].getTimeLeft == 0)
          finishedJobs.push(currJobs.shift)
        end
      end

      # do operations on the current job queue
      timeStep(currJobs)

      puts("Current time: #{timer}. Incrementing timer.")
      timer+=1
    end

    puts("Finished jobs: #{finishedJobs}")

  end # end fcfs

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
