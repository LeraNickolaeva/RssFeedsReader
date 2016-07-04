namespace :update do
    task feed: :enviroment do
        Feed.all.each do |feed|
            SuperfeedrEngine::Engine.subscribe(feed)
        end
    end
end