require 'rails_helper'

RSpec.describe Subject, type: :model do
  describe 'factory' do
    context 'when using standard factory' do
      it 'is valid' do
        expect(build(:subject)).to be_valid
      end
    end
  end

  describe 'validates' do
    context 'When a subject does not have a name' do
      it { expect(build(:subject, name: nil)).not_to be_valid }
    end

    context 'When a subject does not have a weekly_hours attribute' do
      it { expect(build(:subject, weekly_hours: nil)).not_to be_valid }
    end

    context 'When a subject does not have a total_hours attribute' do
      it { expect(build(:subject, total_hours: nil)).not_to be_valid }
    end
  end
end
