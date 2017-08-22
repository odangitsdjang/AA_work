class ArtworkSharesController < ApplicationController
  def create
    newshares = ArtworkShare.new(artworkshare_params)
    if newshares.save
      render json: newshares
    else
      render json: newshares.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    artworkshare = ArtworkShare.find(params[:id])
    artworkshare.destroy
    render json: artworkshare
  end

  private

  def artworkshare_params
    params.require(:artwork_share).permit(:artwork_id, :viewer_id)
  end

end
