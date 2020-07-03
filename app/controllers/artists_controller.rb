class ArtistsController < ApplicationController
  before_action :set_artist, only: %i[show]

  skip_before_action :require_login, only: %i[index show]

  def index
    query = params[:search].to_s
    acl = query.present? ? Artist.search(query) : Artist.order_by_audios_count
    @artists = acl.paginate(page: params[:page], per_page: 30)
  end

  def show
    @artist_mashups = @artist.mashups.paginate(page: params[:mashups_page], per_page: 10)
  end

  private

  def set_artist
    @artist = Artist.find(params[:id])
  end
end
