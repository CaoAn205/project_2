# frozen_string_literal: true

namespace :db do
  desc 'Create first dataset'
  task import_first_dataset: :environment do
    zip_path = 'lib/sample/dataset/SUIM.zip'
    labels_xlsx_path = 'lib/sample/dataset/sample-label.xlsx'
    user = User.admin.order(created_at: :asc).first

    ::CreateDatasetService.perform(zip_path, labels_xlsx_path, user)
  end
end
