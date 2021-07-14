# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Add pgdump to project db
cmd = "pg_restore --verbose --clean --no-owner --no-acl -h localhost -U $(whoami) -d rails-engine_development db/data/rails-engine-dev.pgdump"
puts "Loading project development database with command: "
puts cmd
system(cmd)
