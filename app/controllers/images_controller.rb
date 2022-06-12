class ImagesController < ApplicationController
  def show
    dataset = Dataset.find(params[:dataset_id])
    @image = dataset.images.where(user: current_user).find(params[:id])
  end
end
