class DatasetsController < ApplicationController
  def index; end

  def show
    @dataset = Dataset.find(params[:id])
  end
end
