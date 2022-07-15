# frozen_string_literal: true
require 'faker'

namespace :db do
  desc 'Create first admin user'
  task import_initialize_data: :environment do
    User.create!(name: 'Admin 01', email: 'admin01@email.com.vn', password: 'admin123123', role_type: 'admin')

    11.times.each do
      User.create!(name: Faker::Name.unique.name, email: Faker::Internet.email, password: 'user123123')
    end
  end
end
