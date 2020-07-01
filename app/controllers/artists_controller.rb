class ArtistsController < ApplicationController
  before_action :set_artist, only: %i[show]

  skip_before_action :require_login, only: %i[index show]

  def index
    @artists = Artist.paginate(page: params[:page], per_page: 30)
  end

  def show; end

  private

  def set_artist
    @artist = Artist.find(params[:id])
  end
end
