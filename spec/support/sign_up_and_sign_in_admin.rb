RSpec.shared_context "sign_up_and_sign_in_admin", :shared_context => :metadata do
    let!(:new_admin) { FactoryBot.create(:user, role: :admin)}

    before do

      post '/api/v1/users/sign_in', params:
                        { user: {
                          email: new_admin.email,
                          password: new_admin.password
                        } }
      end
end
