class Api::V1::DatasetsController < Api::V1::BaseController
  def index
    render json: {
      success: true,
      data: ActiveModel::Serializer::CollectionSerializer.new(
        Dataset.order(created_at: :desc).all, serializer: DatasetSerializer
      )
    }
  end

  def create
    dataset = CreateDatasetService.perform(params[:zip_file].path, params[:xlsx_file].path, current_user, params[:dataset_name])

    render json: {
      success: true,
      data: DatasetSerializer.new(dataset)
    }
  end

  def show
    dataset = Dataset.find(params[:id])
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

  def update
    dataset = Dataset.find(params[:id])
    dataset.update!(name: params[:name])

    render json: {
      success: true,
      data: DatasetSerializer.new(dataset)
    }, status: :accepted
  end
end
