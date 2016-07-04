class FeedsController < ApplicationController
  before_action :set_feed, only: [:show, :edit, :update, :destroy, :retrieve]
  load_and_authorize_resource

  def index
    @feeds = current_user.profile.feeds
  end

  def show
  end

  def new
    @feed = Feed.new
  end

  def edit
  end

  def retrieve
    FeedsWorker.perform_in(5.minutes, @feed)
    redirect_to @feed , notice: "Update and saved feeds"
  end

  def create
    type = {basic: 10, medium: 20, premium: 100}
    if current_user.profile.feeds.count < type[current_user.profile.profile_type.to_sym]
      @feed = Feed.new(feed_params)
      @feed.profile_id = current_user.profile.id
      if @feed.save
        Publisher.publish("feeds", @feed.attributes)
        body, ok = SuperfeedrEngine::Engine.subscribe(@feed, {:retrieve => true})
        if ok
          if body
            @feed.notified JSON.parse(body)
          end
          redirect_to @feed, notice: 'Feed was successfully created and subscribed!'
        else
          redirect_to @feed, notice: "Feed was successfully created but we could not subscribe: #{body}"
        end
      else
        render :new
      end
    else
      redirect_to feeds_path, notice: 'You already have 10 channels!'
      end
  end

  def update
    if @feed.update(feed_params)
      Publisher.publish("feeds", @feed.attributes)
      FeederEngine.unsubscribe
      if ok
        FeederEngine.subscribe
        if ok
          redirect_to @feed, notice: 'Feed was successfully updated.'
        else
          render :edit, notice: "Feed was successfully updated, but we could not unsubscribe and resubscribe it. #{body}"
        end
      else
        render :edit, notice: "Feed was successfully updated, but we could not unsubscribe and resubscribe it. #{body}"
      end
    else
      render :edit
    end
  end

  def destroy
    body, ok =  SuperfeedrEngine::Engine.unsubscribe(@feed)
    if ok
      @feed.destroy
      redirect_to feeds_url, notice: 'Feed was successfully destroyed.'
    else
      redirect_to @feed, notice: body
    end
  end

  private
    def set_feed
      @feed = Feed.find(params[:id])
    end

    def feed_params
      params.require(:feed).permit(:title, :url)
    end
end

