# frozen_string_literal: true

namespace :db do
  desc 'Create first admin user'
  task import_initialize_data: :environment do
    User.create!(name: 'Admin 01', email: 'admin01@email.com.vn', password: 'admin123123', role_type: 'admin')
  end
end
