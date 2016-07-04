Sidekiq.configure_server do |config|
  config.periodic do |mgr|
    mgr.register('0 24 * * *', FeedsWorker)
  end
end