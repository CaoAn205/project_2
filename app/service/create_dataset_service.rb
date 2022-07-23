class CreateDatasetService
  class << self
    def perform(zip_file_path, labels_xlsx_path, user, name = "Datatset 1")
      ActiveRecord::Base.transaction do
        dataset = ::Dataset::ImportDatasetImagesService.import!(zip_file_path, user, name)
        Dataset::ImportDatasetLabelService.import!(labels_xlsx_path, dataset)
        dataset
      end
    end
  end
end
