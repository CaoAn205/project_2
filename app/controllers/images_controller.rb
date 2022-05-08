class ImagesController < ApplicationController
  def edit
    @image = current_user.image_attachments.find(params[:id])
  end
end
