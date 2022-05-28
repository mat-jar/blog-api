require 'rails_helper'

RSpec.describe "Sessions" do
  let!(:new_user) { FactoryBot.create(:user) }
  it "signs user in and out" do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    #let!(:my_article) { FactoryBot.create(:user) }
    user = new_user    ## uncomment if using FactoryBot
    user.save

    sign_in user

    expect(@current_user).to eq(user)

    sign_out user

    expect(@current_user).to be_nil
  end
end
