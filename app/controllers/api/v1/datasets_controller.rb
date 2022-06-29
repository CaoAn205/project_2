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

    render json: {
      success: true,
      data: ActiveModel::Serializer::CollectionSerializer.new(
        dataset.images, serializer: ImageSerializer
      )
    }
  end
end
