# project_2
Project 2

Set up instruction:
  - run docker -> docker-compose up --build 
  - build FE -> docker-compose exec web rails assets:precompile
  - create first admin user -> docker-compose exec web rake db:import_initialize_data
