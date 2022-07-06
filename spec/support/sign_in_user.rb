RSpec.shared_context "sign_in_user", :shared_context => :metadata do

    before do
      post '/api/v1/users/sign_in', params:
                        { user: {
                          email: new_user.email,
                          password: new_user.password
                        } }
      end
end
