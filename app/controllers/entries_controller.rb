class EntriesController < ApplicationController
  include FilmFan::Commentable
  before_action :set_entry, only: [:show]

  def autocomplete
    render json: Entry.search(params[:query], autocomplete: true, limit: 10).map(&:title)
  end
  def index
    if params[:query].present?
      @entries = Entry.search(params[:query])
    else
      @entries = Entry.all
    end
  end

  def show
    @entry = Entry.find(params[:id])
  end
  def new
    @entry = Entry.new
  end

  def upvote
    @entry = Entry.find(params[:id])
    @entry.upvote_by current_user
    respond_to do |format|
      format.html {redirect_to :back }
      format.json { render json: { count: @entry.get_upvotes.size } }
    end
  end

  def downvote
    @entry = Entry.find(params[:id])
    @entry.downvote_by current_user
    respond_to do |format|
      format.html {redirect_to :back }
      format.json { render json: { count: @entry.get_downvotes.size } }
      end
  end

  private
    def set_entry
      @entry = Entry.find(params[:id])
    end

    def entry_params
      params.require(:entry).permit(:feed_id, :atom_id, :title, :url, :content, :date)
    end
end
