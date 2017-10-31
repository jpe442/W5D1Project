require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #new" do
    get :new, user: {}

    it "validates the presence of the sign up page" do 
      expect(response).to render_template("new")
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
    get :create, params: { user: { }}

    it "validates the presence of the user's email and password"
  end

  describe "PATCH #update" do

  end

  describe "DELETE #destroy" do

  end
end
