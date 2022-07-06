RSpec.shared_context "sign_up_and_sign_in_user", :shared_context => :metadata do
    let!(:new_user) { FactoryBot.create(:user)}

    before do

      post '/api/v1/users/sign_in', params:
                        { user: {
                          email: new_user.email,
                          password: new_user.password
                        } }
      end
end
