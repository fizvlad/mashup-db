class MashupsController < ApplicationController
  before_action :set_mashup, only: %i[show update]

  skip_before_action :require_login, only: %i[show index]

  def index
    query = params[:search].to_s
    mcl = query.present? ? Mashup.search(query) : Mashup
    @mashups = mcl.paginate(page: params[:page], per_page: 30)
  end

  def show; end

  def update
    # TODO
  end

  private

  def set_mashup
    @mashup = Mashup.find(params[:id])
  end
end
