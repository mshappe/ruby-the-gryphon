require 'rails_helper'

RSpec.describe Manage::UsersController, type: :controller do
  it_behaves_like 'a management controller', :show, :user
  it_behaves_like 'a management controller', :edit, :user
  it_behaves_like 'a management updater', :user, { email: 'wombat@face.com' }, :email
  it_behaves_like 'a management deleter', :user
end
