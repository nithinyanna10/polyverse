# Worker pool for concurrent job processing
class WorkerPool
  def initialize(size = 5)
    @size = size
    @workers = []
    @queue = Queue.new
  end
  
  def start
    @size.times do
      @workers << Thread.new do
        loop do
          job = @queue.pop
          process_job(job)
        end
      end
    end
  end
  
  def enqueue(job)
    @queue << job
  end
  
  private
  
  def process_job(job)
    # Process job
    sleep(0.1)
  end
end

