class Api::V1::ImageSectorsController < Api::V1::BaseController
  def update
    dataset = Dataset.find(params[:dataset_id])
    image = dataset.images.find(params[:image_id])
    image_sector = image.image_sectors.find(params[:id])

    image_sector.update!(image_sector_params)

    render json: {
      success: true,
      data: {
        image_sector: ImageSectorSerializer.new(image_sector)
      }
    }
  end

  private

  def image_sector_params
    params.require(:image_sector).permit(:label_id, :area_data).tap do |p|
      p[:confirmed_at] = Time.zone.now if params[:confirm].present?
    end
  end
end
