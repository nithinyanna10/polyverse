# Job processor for background tasks
class JobProcessor
  def initialize
    @queue = []
    @processing = false
  end
  
  def enqueue(job)
    @queue << {
      id: SecureRandom.uuid,
      data: job,
      status: 'queued',
      created_at: Time.now
    }
  end
  
  def process_next
    return nil if @queue.empty?
    
    job = @queue.shift
    job[:status] = 'processing'
    job[:started_at] = Time.now
    
    # Simulate processing
    sleep(0.1)
    
    job[:status] = 'completed'
    job[:completed_at] = Time.now
    
    job
  end
  
  def queue_size
    @queue.size
  end
end

