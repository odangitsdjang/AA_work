class AlbumsController < ApplicationController
  # albums#new
  #      albums POST   /albums(.:format)                      albums#create
  #  edit_album GET    /albums/:id/edit(.:format)             albums#edit
  #       album GET    /albums/:id(.:format)                  albums#show
  #             PATCH  /albums/:id(.:format)                  albums#update
  #             PUT    /albums/:id(.:format)                  albums#update
  #             DELETE /albums/:id(.:format)                  albums#destroy
  def new
    @album = Album.new
    render :new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to album_url(@album)
    else
      flash[:errors] = ["Wrong album"]
      redirect_to new_album_url
    end
  end

  def edit
  end

  def show
  end

  def 


end
