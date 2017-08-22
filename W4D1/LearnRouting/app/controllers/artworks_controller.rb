class ArtworksController < ApplicationController

#  Artworks owned by a user and
#  shared with the user.
  def index
    @user = User.find(params[:id])
    # the Artworks owned by a user and
    artworks = Artwork.find_by(artist_id: @user.id)
    # the Artworks shared with the user.
    other = Art
    artworks.merge(other)
    render json: @artworks
  end

  def create
    artwork = Artwork.new(artwork_params)
    if artwork.save
      render json: artwork
    else
      render json: artwork.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    render json: Artwork.find(params[:id])
  end

  def update
    artwork = Artwork.find(params[:id])
    if artwork.update(artwork_params)
      render json: artwork
    else
      render json: artwork.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    artwork = Artwork.find(params[:id])
    artwork.destroy
    render json: artwork
  end

  private

  def artwork_params
    params.require(:artwork).permit(:title, :image_url, :artist_id)
  end
end
