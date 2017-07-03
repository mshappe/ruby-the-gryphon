namespace :roles do
  desc 'Add a role to a user, e.g. `rake roles:add[yehudah.ns@zoho.com,admin]`'
  task :add, [:email, :role] => [:environment] do |_t, args|
    raise ArgumentError.new('No email specified') if args[:email].blank?
    raise ArgumentError.new('No role specified') if args[:role].blank?

    user = User.find_by!(email: args[:email])
    Role.find_by!(name: args[:role])

    user.add_role(args[:role].to_sym)
    puts "User #{user.email} now has roles #{user.roles.collect(&:name).join(', ')}"
  end

  desc 'Create a role e.g. `rake roles:create[admin]`'
  task :create, [:role] => [:environment] do |_t, args|
    raise ArgumentError.new('No role specified') if args[:role].blank?

    Role.find_or_create_by(name: args[:role])
    puts "Roles are now #{Role.all.collect(&:name).join(', ')}"
  end
end
