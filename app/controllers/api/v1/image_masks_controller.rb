class Api::V1::ImageMasksController < Api::V1::BaseController
  def create
    dataset = Dataset.find(params[:dataset_id])
    image = dataset.images.find(params[:image_id])

    mask = image.image_masks.create!(image_mask_params)
    image.image_sectors.update_all(confirmed_at: Time.zone.now)

    render json: {
      success: true,
      segmentation_mask: ImageMaskSerializer.new(mask),
    }
  end

  def update
    dataset = Dataset.find(params[:dataset_id])
    image = dataset.images.find(params[:image_id])

    image.image_sectors.update_all(confirmed_at: Time.zone.now)

    render json: {
      success: true,
    }, status: :accepted
  end

  private

  def image_mask_params
    params.permit(:file)
  end
end
