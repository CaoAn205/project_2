class Api::V1::ImagesController < Api::V1::BaseController
  def show
    dataset = Dataset.find(params[:dataset_id])
    image = dataset.images.find(params[:id])

    render json: {
      success: true,
      data: {
        image: ImageSerializer.new(image),
        labels: ActiveModel::Serializer::CollectionSerializer.new(
          dataset.labels, serializer: LabelSerializer
        )
      }
    }
  end
end
