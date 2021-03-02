class PartsController < ApplicationController
  def index
    @song = Song.new name: params[:title], artist: params[:artist]
  end
end
