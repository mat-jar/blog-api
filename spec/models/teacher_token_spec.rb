require 'rails_helper'

RSpec.describe TeacherToken, type: :model do
  describe 'is_user_a_teacher validation' do

    let!(:new_teacher) { FactoryBot.create(:user, role: :teacher) }
    let!(:new_student) { FactoryBot.create(:user, role: :student) }

    subject { TeacherToken.new( teacher: new_teacher)}
      context 'given a user that is a teacher' do
        it 'TeacherToken is valid' do
          expect(subject).to be_valid
      end
    end

      context 'given a teacher that is NOT a teacher' do
        it 'TeacherToken is NOT valid' do
          subject.teacher = new_student
          expect(subject).to_not be_valid
      end
    end
  end
end
