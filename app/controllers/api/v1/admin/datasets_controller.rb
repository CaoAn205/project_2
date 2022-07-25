class Api::V1::Admin::DatasetsController < Api::V1::Admin::BaseController
  def update
    dataset = Dataset.find(params[:id])
    dataset.update!(dataset_params)

    render json: {
      success: true
    }, status: :accepted
  end

  def destroy
    dataset = Dataset.find(params[:id])
    dataset.destroy!

    render json: {
      success: true,
      data: ActiveModel::Serializer::CollectionSerializer.new(
        Dataset.order(created_at: :desc).all, serializer: DatasetSerializer
      )
    }, status: :accepted
  end

  private

  def dataset_params
    params.require(:dataset).permit(:name)
  end
end
