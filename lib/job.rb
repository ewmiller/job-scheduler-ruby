class Job
  @startTime = 0
  @jobLength = 0
  @timeLeft = 0
  @waitTime = 0

  def initialize(startTime, jobLength)
    @startTime = startTime
    @jobLength = jobLength
    @timeLeft = jobLength
  end

  def wait
    @waitTime += 1
  end

  def increment
    @timeLeft -= 1
  end

  def getStartTime
    return @startTime
  end

  def getTimeLeft
    return @timeLeft
  end

  def getJobLength
    return @jobLength
  end

end
