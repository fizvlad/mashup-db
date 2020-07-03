class MashupsController < ApplicationController
  before_action :set_mashup, only: %i[show update_sources]

  skip_before_action :require_login, only: %i[show index]

  skip_before_action :verify_authenticity_token, only: %i[update_sources]

  def index
    query = params[:search].to_s
    mcl = query.present? ? Mashup.search(query) : Mashup.order_by_first_post_date
    @mashups = mcl.paginate(page: params[:page], per_page: 30)
  end

  def show; end

  def update_sources
    parameters = sources_params
    if parameters[:type] == 'add'
      add_source(@mashup, parameters)
    elsif parameters[:type] == 'remove'
      remove_source(@mashup, parameters)
    else
      render json: { error: 'unknown `type`' }, status: :bad_request
    end
    render json: @mashup.sources.map { |s| { artist: s.artist.name, title: s.title } }.to_json,
           status: :ok
  end

  private

  def set_mashup
    @mashup = Mashup.find(params[:id])
  end

  def sources_params
    params.require(:sources).permit(:type, :artist, :title)
  end

  def add_source(mashup, parameters)
    ActiveRecord::Base.transaction do
      artist = Artist.find_or_create_by!(name: parameters[:artist])
      audio = Audio.find_or_create_by!(artist_id: artist.id, title: parameters[:title])
      mashup.audios << audio unless mashup.audio_ids.include?(audio.id)
    end
  end

  def remove_source(mashup, parameters)
    ActiveRecord::Base.transaction do
      artist = Artist.find_by!(name: parameters[:artist])
      audio = Audio.find_by!(artist_id: artist.id, title: parameters[:title])
      mashup.audios.delete(audio)
    end
  end
end
