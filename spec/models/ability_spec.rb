require 'rails_helper'

RSpec.describe Ability, type: :model do
  let(:user) { create :user }
  subject { Ability.new(user) }

  describe 'Admin user' do
    before :each do
      user.add_role :admin
    end

    it { is_expected.to have_abilities :manage, User.new }
    it { is_expected.to have_abilities :manage, Person.new }
    it { is_expected.to have_abilities :manage, Persona.new }
  end

  describe 'Ordinary user to their own stuff' do
    it { is_expected.to have_abilities [:read, :update], Person.new(user_id: user.id) }
    it { is_expected.to have_abilities [:create, :read, :update, :destroy], Persona.new(user_id: user.id) }

    # Person records are not so easily destroyed
    it { is_expected.to not_have_abilities [:destroy], Person.new(user_id: user.id) }
  end

  describe "Ordinary user to other's stuff" do
    it { is_expected.to have_abilities :read, Person.new }
    it { is_expected.to have_abilities :read, Persona.new }

    it { is_expected.to not_have_abilities [:create, :update, :destroy], Person.new }
    it { is_expected.to not_have_abilities [:create, :update, :destroy], Persona.new }
  end

  describe 'Visitor' do
    subject { Ability.new(nil) }

    [Event, Person, Persona].each do |k|
      it { is_expected.to have_abilities :read, k.new }
    end
  end

end