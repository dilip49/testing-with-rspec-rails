# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with a first name, last name, email, and password' do
    user = User.new(
      first_name: 'dilip',
      last_name: 'bhaidiya',
      email: 'dilip@gmail.com'
    )

    expect(user).to be_valid
  end

  it 'is invalid without a user first_name' do
    user = User.new(first_name: nil)
    user.valid?

    expect(user.errors[:first_name]).to include("can't be blank")
  end

  it 'is invalid without a user last_name' do
    user = User.new(last_name: nil)
    user.valid?

    expect(user.errors[:last_name]).to include("can't be blank")
  end

  it 'is invalid with a user duplicate email' do
    User.create(
      first_name: 'dilip',
      last_name: 'bhaidiya',
      email: 'dilip@gmail.com'
    )

    user = User.new(
      first_name: 'John',
      last_name: 'carter',
      email: 'dilip@gmail.com'
    )

    user.valid?
    expect(user.errors[:email]).to include('has already been taken')
  end

  it "returns a user's full name as string" do
    user = User.create(
      first_name: 'John',
      last_name: 'carter',
      email: 'dilip@gmail.com'
    )

    expect(user.name).to eq 'John carter'
  end
end
