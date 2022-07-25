class Api::V1::Admin::LabelsController < Api::V1::Admin::BaseController
  def index
    dataset = Dataset.find(params[:dataset_id])

    render json: {
      success: true,
      data: ActiveModel::Serializer::CollectionSerializer.new(
        dataset.labels.order(created_at: :desc), serializer: LabelSerializer
      )
    }
  end

  def create
    dataset = Dataset.find(params[:dataset_id])
    label = dataset.labels.create!(label_params)

    render json: {
      success: true,
      data: LabelSerializer.new(label)
    }
  end

  def update
    dataset = Dataset.find(params[:dataset_id])
    label = dataset.labels.find(params[:id])
    label.update!(label_params)

    render json: {
      success: true,
      data: ActiveModel::Serializer::CollectionSerializer.new(
        dataset.labels.order(created_at: :desc), serializer: LabelSerializer
      )
    }, status: :accepted
  end

  private

  def label_params
    params.require(:label).permit(:category_name, :color_code, :category_code)
  end
end
