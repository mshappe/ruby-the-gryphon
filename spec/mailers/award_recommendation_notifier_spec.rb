require "rails_helper"

RSpec.describe AwardRecommendationNotifier, type: :mailer do
  describe '#new_recommendation' do
    let(:award) { double Award, name: Faker::Name.name }
    let(:persona) { double Persona, name: Faker::Name.name, description: Faker::Lorem.paragraph }
    let(:person) { double Person, name: Faker::Name.name}
    let(:rec) { double AwardRecommendation, id: 1, persona_name: persona.name, person_name: person.name, branch_name: 'Doom', gender: 'M', persona_description: Faker::Lorem.paragraph, is_youth: false, reason: Faker::Lorem.paragraphs(3).join('\r\n') }
    let(:royal) { double User, email: Faker::Internet.email }
    let(:sub_person) { double Person, name: Faker::Name.name }
    let(:sub_persona) { double Persona, name: Faker::Name.name }
    let(:sub_personas) { class_double Persona }
    let(:mail) { AwardRecommendationNotifier.new_recommendation(rec.id) }

    before :each do
      expect(rec).to receive(:award).twice { award }
      expect(rec).to receive(:persona) { persona }
      expect(rec).to receive(:submitted_by_person) { sub_person }
      expect(sub_person).to receive(:personas) { sub_personas }
      expect(sub_personas).to receive(:primary) { sub_persona }
      expect(User).to receive(:with_any_role).with(:royalty, :award_manager) { [royal] }
      expect(AwardRecommendation).to receive(:find).with(rec.id) { rec }
    end

    it 'should succeed' do
      expect(mail.subject).to match "New Award Rec: #{award.name} for #{persona.name}"
      expect(mail.to).to match_array [royal.email]
      expect(mail.body.encoded).to match %r[Recommended by: #{sub_persona.name} \(#{sub_person.name}\)]
      expect(mail.body.encoded).to match %r[Recommendation for: #{persona.name} \(#{person.name}\) of Doom]
      expect(mail.body.encoded).to match %r[To receive: #{award.name}]
      expect(mail.body.encoded).to match %r[Gender: M]
      expect(mail.body.encoded).to match %r[Submitter-provided persona description: #{rec.persona_description}]
      expect(mail.body.encoded).to match %r[Candidate-provided persona description: #{persona.description}]
      expect(mail.body.encoded).to match %r[Under 18\? No]
      expect(mail.body.encoded).to match %r[Reason:]
      expect(mail.body.encoded).to match %r[#{rec.reason[0..20]}]
      expect(mail.body.encoded).to match %r{#{award_recommendation_url(rec.id)}}
    end
  end
end
