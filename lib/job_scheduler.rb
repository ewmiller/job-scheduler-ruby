##
# Overall approach:
# Each line of each trace file has specific info about the jobs to simulate.
# I've created a "job" class to represent these. Instances of the job class will
# be declared within processTrace as it iterates through a file's contents.
#

require_relative 'job.rb'

class JobScheduler

  def initialize
  end

  # perform operations on currently queued jobs
  def timeStepFCFS(jobQueue)
    if(jobQueue.empty?)
      return
    else
      # increment the job in the front of the line. Add to wait time of others
      jobQueue[0].increment
      (1..((jobQueue.length)-1)).each do |i|
        jobQueue[i].wait
      end
    end
  end

  def timeStepRR(jobQueue)
    if(jobQueue.empty?)
      return
    else
      jobQueue[0].increment
      (1..((jobQueue.length)-1)).each do |i|
        jobQueue[i].wait
      end
      # Here's the money, right here
      jobQueue.push(jobQueue.shift)
    end
  end

  # FCFS algorithm
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
    totalWaitTime = 0

    # for each line in the trace file that describes a job, create job object
    (3..((traceArr.length)-1)).each do |i|
      str = traceArr[i].split(" ")
      allJobs.push(Job.new(str[0], str[1]))
    end

    while(timer <= simTime) do
      # take the next job from the allJobs queue if necessary
      unless allJobs.empty?
        nextTime = allJobs[0].getStartTime
        if(nextTime == timer)
          currJobs.push(allJobs.shift)
        end
      end

      unless currJobs.empty?
        if(currJobs[0].getTimeLeft == 0)
          finishedJobs.push(currJobs.shift)
        end
      end

      # do operations on the current job queue
      timeStepFCFS(currJobs)
      timer+=1
    end

    finishedJobs.each do |job|
      totalWaitTime += job.getWaitTime
    end

    puts("Finished jobs from #{traceFile}.")
    puts("Total wait time: #{totalWaitTime}")
    puts("Total jobs: #{totalJobs}")
    averageWait = totalWaitTime.to_f/totalJobs.to_f
    puts("Average wait time: #{averageWait}")

    formattedFile = traceFile.split("/").pop.split(".").shift
    outputFile.puts("FCFS #{formattedFile}: #{averageWait}")
  end # end fcfs

  def rr(traceFile, outputFile)
    puts("Analyzing #{traceFile} in RR")

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
      totalWaitTime = 0

      # for each line in the trace file that describes a job, create job object
      (3..((traceArr.length)-1)).each do |i|
        str = traceArr[i].split(" ")
        allJobs.push(Job.new(str[0], str[1]))
      end

      jobIterator = 0
      while(timer <= simTime) do
        unless allJobs.empty?
          nextTime = allJobs[0].getStartTime
          if(nextTime == timer)
            currJobs.push(allJobs.shift)
          end
        end # end unless

        unless currJobs.empty?
          if(currJobs[0].getTimeLeft == 0)
            finishedJobs.push(currJobs.shift)
          end
        end # end unless

        timeStepRR(currJobs)
        timer+=1
      end # end while

      finishedJobs.each do |job|
        totalWaitTime += job.getWaitTime
      end

      puts("Finished jobs from #{traceFile}.")
      puts("Total wait time: #{totalWaitTime}")
      puts("Total jobs: #{totalJobs}")
      averageWait = totalWaitTime.to_f/totalJobs.to_f
      puts("Average wait time: #{averageWait}")

      formattedFile = traceFile.split("/").pop.split(".").shift
      outputFile.puts("RR #{formattedFile}: #{averageWait}")
  end # end rr

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

p1 = JobScheduler.new
p1.main
