class Api::V1::ImagesController < Api::V1::BaseController
  def create
    dataset = Dataset.find(params[:dataset_id])
    image = dataset.images.build(image_params)

    ActiveRecord::Base.transaction do
      image.save!
      Image::SegmentationService.new(image).execute!
    end

    render json: {
      success: true,
      data: {
        image: ImageSerializer.new(image),
        labels: ActiveModel::Serializer::CollectionSerializer.new(
          dataset.labels, serializer: LabelSerializer
        ),
        image_sectors: ActiveModel::Serializer::CollectionSerializer.new(
          image.image_sectors.includes(:label), serializer: ImageSectorSerializer
        )
      }
    }
  end

  def show
    dataset = Dataset.find(params[:dataset_id])
    image = dataset.images.find(params[:id])

    render json: {
      success: true,
      data: {
        image: ImageSerializer.new(image),
        labels: ActiveModel::Serializer::CollectionSerializer.new(
          dataset.labels, serializer: LabelSerializer
        ),
        image_sectors: ActiveModel::Serializer::CollectionSerializer.new(
          image.image_sectors.includes(:label), serializer: ImageSectorSerializer
        )
      }
    }
  end

  private

  def image_params
    params.permit(:file).tap do |p|
      p[:user_id] = current_user.id
    end
  end
end
