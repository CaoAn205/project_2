class Api::V1::ImagesController < Api::V1::BaseController
  def create
    dataset = Dataset.find(params[:dataset_id])
    image = dataset.images.build(image_params)

    ActiveRecord::Base.transaction do
      image.save!
      Image::SegmentationService.new(image).execute!
    end

    images = dataset.images.order(created_at: :desc).includes(:image_sectors, :image_masks).page(params[:page])

    render json: {
      success: true,
      data: ActiveModel::Serializer::CollectionSerializer.new(
        images, serializer: ImageSerializer
      ),
      dataset: DatasetSerializer.new(dataset),
      total_pages: images.total_pages,
      total_count: images.total_count,
      total_record_page: images.size,
    }
  end

  def show
    dataset = Dataset.find(params[:dataset_id])
    image = dataset.images.find(params[:id])

    Image::SegmentationService.new(image).execute! if image.image_sectors.blank?

    render json: {
      success: true,
      data: {
        image: ImageSerializer.new(image),
        labels: ActiveModel::Serializer::CollectionSerializer.new(
          dataset.labels.order(created_at: :desc), serializer: LabelSerializer
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
