 class PhotoController < ApplicationController
    def destroy
      @photo = Photo.find(params[:id])
      @photo.remove_image!
      @photo.destroy
      render json: {id: params[:id], status: "destroyed"}
    end
 end