require "rails_helper"

RSpec.describe UsersAPI do
  context "POST /api/users" do
    let(:user_params) do
      {
        name: "name",
        last_name: "last_name",
        birthday: "2022-04-29",
        phone_number: "phone_number",
        email: "email",
        usc_number: "usc_number",
        telegram_id: "telegram_id",
      }
    end

    context "when user doesn't exist" do
      it "creates a user" do
        post "/api/users", params: { user: user_params }

        expect(response.status).to eq(201)
        expect(JSON.parse(response.body)).to be_nil

        expect(User.count).to eq(1)
        user = User.last
        expect(user.name).to eq("name")
        expect(user.last_name).to eq("last_name")
        expect(user.birthday).to eq(Date.parse("2022-04-29"))
        expect(user.phone_number).to eq("phone_number")
        expect(user.email).to eq("email")
        expect(user.usc_number).to eq("usc_number")
        expect(user.telegram_id).to eq("telegram_id")
      end
    end

    context "when user already exists" do
      let(:updated_params) do
        {
          name: "updated name",
          last_name: "updated last_name",
          birthday: "2022-04-30",
          phone_number: "update phone_number",
          email: "email",
          usc_number: "updated usc_number",
          telegram_id: "updated telegram_id",
        }
      end

      before do
        User.create!(user_params)
      end

      it "updates the user" do
        post "/api/users", params: { user: updated_params }

        puts response.body
        expect(response.status).to eq(201)
        expect(JSON.parse(response.body)).to be_nil

        expect(User.count).to eq(1)
        user = User.last
        expect(user.name).to eq(updated_params[:name])
        expect(user.last_name).to eq(updated_params[:last_name])
        expect(user.birthday).to eq(Date.parse("2022-04-30"))
        expect(user.phone_number).to eq(updated_params[:phone_number])
        expect(user.email).to eq(updated_params[:email])
        expect(user.usc_number).to eq(updated_params[:usc_number])
        expect(user.telegram_id).to eq(updated_params[:telegram_id])
      end
    end
  end
end
