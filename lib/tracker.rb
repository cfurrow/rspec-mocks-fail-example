class Tracker
  def track(payload)
    logger.info(payload) 
  end

  private

  def logger
    @logger ||= Logger.new(STDOUT)
  end
end
