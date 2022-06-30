RSpec.shared_context "sign_up_and_sign_in_student", :shared_context => :metadata do
    let!(:new_student) { FactoryBot.create(:user, role: :student)}

    before do

      post '/api/v1/users/sign_in', params:
                        { user: {
                          email: new_student.email,
                          password: new_student.password
                        } }
      end
end
