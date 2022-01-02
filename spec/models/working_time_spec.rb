require 'rails_helper'

RSpec.describe WorkingTime, type: :model do
  describe 'factory' do
    context 'when using standard factory' do
      it { expect(build(:working_time)).to be_valid }
    end
  end

  describe 'factory' do
    context 'when working_time is not linked to any subject' do
      it { expect(build(:working_time, subject_id: nil)).not_to be_valid }
    end

    context 'when working_time does not have an time_i attribute' do
      it { expect(build(:working_time, time_i: nil)).not_to be_valid }
    end

    context 'when working_time does not have an time_e attribute' do
      it { expect(build(:working_time, time_e: nil)).not_to be_valid }
    end
  end
end
