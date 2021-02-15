# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  
  it "has a valid factory" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it 'is valid with a first name, last name, email, and password' do
    user = User.new(
      first_name: 'dilip',
      last_name: 'bhaidiya',
      email: 'dilip@gmail.com'
    )

    expect(user).to be_valid
  end

  it 'is invalid without a user first_name' do
    user = FactoryBot.build(:user, first_name: nil)
    user.valid?

    expect(user.errors[:first_name]).to include("can't be blank")
  end

  it 'is invalid without a user last_name' do
    user = FactoryBot.build(:user, last_name: nil)
    user.valid?

    expect(user.errors[:last_name]).to include("can't be blank")
  end

  it 'is invalid with a user duplicate email' do
    FactoryBot.create(:user, email: "karan@gmail.com")
    user = FactoryBot.build(:user, email: "karan@gmail.com")

    user.valid?
    expect(user.errors[:email]).to include('has already been taken')
  end

  it "returns a user's full name as string" do
    user = FactoryBot.build(:user, first_name: "john", last_name: "carter")

    expect(user.name).to eq 'john carter'
  end
end
