class FeedsWorker
  include Sidekiq::Worker

  def perform
    Feed.all.each do |feed|
      body, ok = SuperfeedrEngine::Engine.retrieve(feed)
      if ok
        feed.notified JSON.parse(body)
      end
    end
  end
end