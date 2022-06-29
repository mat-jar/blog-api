RSpec.shared_context "sign_up_and_sign_in_teacher", :shared_context => :metadata do
    let!(:new_teacher) { FactoryBot.create(:user, role: :teacher)}

    before do
      
      post '/api/v1/users/sign_in', params:
                        { user: {
                          email: new_teacher.email,
                          password: new_teacher.password
                        } }
      end
end
