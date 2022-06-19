class CreateDatasetService
  class << self
    def perform(zip_file_path, labels_xlsx_path, user)
      ActiveRecord::Base.transaction do
        dataset = ::Dataset::ImportDatasetImagesService.import!(zip_file_path, user)
        Dataset::ImportDatasetLabelService.import!(labels_xlsx_path, dataset)
      end
    end
  end
end
