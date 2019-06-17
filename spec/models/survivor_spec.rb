require 'rails_helper'

RSpec.describe Survivor, type: :model do
  describe 'associations' do
    it { expect(Survivor.reflect_on_association(:survivor_items).macro).to eq :has_many }
    it { expect(Survivor.reflect_on_association(:send_complaints).macro).to eq :has_many }
    it { expect(Survivor.reflect_on_association(:received_complaints).macro).to eq :has_many }
  end

  describe 'validations' do
    context 'with valid attributes' do
      let(:survivor) { create :survivor }

      it { expect(survivor).to be_valid }

      it { expect { survivor }.to change{ Survivor.count }.by 1 }
    end

    context 'without name' do
      let(:survivor) { build :survivor, name: nil }

      it { expect(survivor).to be_invalid }

      it 'add an error to name validation' do
        survivor.valid?
        expect(survivor.errors[:name].size).to eq 1
      end
    end

    context 'without birth_date' do
      let(:survivor) { build :survivor, birth_date: nil }

      it { expect(survivor).to be_invalid }

      it 'add an error to birth_date validation' do
        survivor.valid?
        expect(survivor.errors[:birth_date].size).to eq 1
      end
    end

    context 'without gender' do
      let(:survivor) { build :survivor, gender: nil }

      it { expect(survivor).to be_invalid }

      it 'add errors to gender validation' do
        survivor.valid?
        expect(survivor.errors[:gender].size).to eq 1
      end
    end

    context 'without last_location' do
      let(:survivor) { build :survivor, last_location: nil }

      it { expect(survivor).to be_invalid }

      it 'add errors to last_location validation' do
        survivor.valid?
        expect(survivor.errors[:last_location].size).to eq 1
      end
    end
  end
end
