# frozen_string_literal: true

namespace :db do
  desc 'Create first dataset'
  task import_first_dataset: :environment do
    ::Dataset::ImportDatasetImagesService.perform('lib/sample/dataset/SUIM.zip')
  end
end
