require 'rails_helper'

RSpec.describe Ability, type: :model do
  let(:user) { create :user }
  subject { Ability.new(user) }

  describe 'Admin user' do
    before :each do
      user.add_role :admin
    end

    [Branch, Event, Person, Persona, User].each do |klass|
      it { is_expected.to have_abilities :manage, klass.new }
    end
  end

  describe 'Event officer' do
    before :each do
      user.add_role :event_officer # TODO this role will eventually be on Office (or WarrantType) rather than User
    end

    it { is_expected.to have_abilities :manage, Event.new }
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

    [Branch, Person, Persona].each do |k|
      it { is_expected.to have_abilities :read, k.new }
    end

    it { is_expected.to have_abilities :read, Event.new(submission_state: 'approved') }
    it { is_expected.to not_have_abilities :read, Event.new(submission_state: 'queued') }

  end

end