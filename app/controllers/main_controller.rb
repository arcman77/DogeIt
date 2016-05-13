class MainController < ApplicationController
	def index
		if params[:id]
			@current_image = Photo.find(params[:id])
		else
			@current_image = Photo.last
		end
		@voted = Vote.already_voted?(request.remote_ip)
		@image = Photo.new
	end

	def create
		@photo = Photo.new(photo_params)
		@photo.ip = request.remote_ip
		if params[:photo][:image]
			@photo.caption = nil if @photo.caption == ""
			Vote.clear_votes if @photo.save
		end
		redirect_to '/?id='+@photo.id.to_s
	end

	def keep
		Vote.place_vote(true, request.remote_ip)
		redirect_to '/'
	end

	def kill
		Vote.place_vote(false, request.remote_ip)
		redirect_to '/'
	end

	private

	def photo_params
		params.require(:photo).permit(:caption, :image)
	end
end



