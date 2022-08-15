require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validate is_teacher_and_student' do
    let!(:new_user) { FactoryBot.build(:user) }
    let!(:new_teacher) { FactoryBot.build(:user, role: :teacher) }
    subject { User.new(email: new_user.email,
                       password: new_user.password,
                       teacher_id: new_teacher.id)}

     context 'given teacher as a teacher' do

       it 'User is valid' do
         expect(subject).to be_valid
       end
     end

  end
end
