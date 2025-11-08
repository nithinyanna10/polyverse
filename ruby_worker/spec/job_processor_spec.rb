require_relative '../lib/job_processor'

RSpec.describe JobProcessor do
  let(:processor) { JobProcessor.new }
  
  describe '#enqueue' do
    it 'adds job to queue' do
      processor.enqueue({task: 'test'})
      expect(processor.queue_size).to eq(1)
    end
  end
end

