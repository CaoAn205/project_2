class Dataset::ImportDatasetLabelService
  class << self
    def import!(file_path, dataset)
      return unless File.exists?(file_path)

      workbook = ::RubyXL::Parser.parse(file_path)
      datas = workbook[0].map { |row| row&.cells }.take_while(&:present?).map { |t| t.map { |r| r&.value.to_s.strip } }.take_while { |row| row[1].present? }

      datas[1..-1].each do |row|
        label = dataset.labels.new
        label.category_name = row[0]
        label.category_code = row[1]
        label.color_code = row[2]
        label.save!
      end
    end
  end
end
