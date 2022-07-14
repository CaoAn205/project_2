class Api::V1::DatasetsController < Api::V1::BaseController
  def index
    render json: {
      success: true,
      data: ActiveModel::Serializer::CollectionSerializer.new(
        Dataset.all, serializer: DatasetSerializer
      )
    }
  end

  def show
    dataset = Dataset.find(params[:id])
    images = dataset.images.page(params[:page])

    render json: {
      success: true,
      data: ActiveModel::Serializer::CollectionSerializer.new(
        images, serializer: ImageSerializer
      ),
      total_pages: images.total_pages,
      total_count: images.total_count,
      total_record_page: images.size,
    }
  end
end
