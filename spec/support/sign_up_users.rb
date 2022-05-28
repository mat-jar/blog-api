RSpec.shared_context "sign_up_users", :shared_context => :metadata do
    let!(:new_user) { FactoryBot.build(:user)}
    before do
      post '/api/v1/users', params:
                        { user: {
                          email: new_user.email,
                          password: new_user.password
                        } }
      end
end
