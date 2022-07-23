class Image < ApplicationRecord
  mount_uploader :file, FileUploader
  paginates_per 20

  belongs_to :dataset, counter_cache: true
  belongs_to :user

  has_many :image_sectors, dependent: :destroy
  has_many :image_masks, dependent: :destroy

  def lastest_mask
    image_masks.order(created_at: :desc).first
  end

  def segmentation_mask
    return lastest_mask if lastest_mask&.file.present?

    create_file_from_response
  end

  private

  def call_segmentation_image_api api = "http://#{ENV['LOCAL_IPV4']}:8000#{Settings.segnmentation_image_api}"
    response = RestClient.post(api, { :file => File.new(file.path, 'rb') })
    response.body
  end

  def create_file_from_response
    file_data = call_segmentation_image_api
    image_file_name = self.file.identifier
    image_file_extension = File.extname(image_file_name)
    file_name = File.basename(image_file_name, image_file_extension)

    temp_path = "/tmp/mask/#{id}"
    FileUtils.mkdir_p(temp_path) unless Dir.exist?(temp_path)

    mask_file = File.new(Rails.root.join(temp_path, "#{image_file_name}_mask#{image_file_extension}"), 'w')
    mask_file.syswrite(file_data)

    mask = image_masks.new(file: mask_file)
    mask.save!
    mask
  ensure
    File.delete(mask_file.path) if File.exist?(mask_file.path)
  end
end
