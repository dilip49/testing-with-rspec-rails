# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Project, type: :model do
  it 'does not allow duplicate project names per user' do
    user = User.create(
      first_name: 'John',
      last_name: 'carter',
      email: 'john@gmail.com'
    )

    user.projects.create(
      name: 'Test Project'
    )

    new_project = user.projects.build(
      name: 'Test Project'
    )

    new_project.valid?
    expect(new_project.errors[:name]).to include('has already been taken')
  end

  it 'allows two user to share a project name' do
    user = User.create(
      first_name: 'joe',
      last_name: 'deo',
      email: 'joe@gmail.com'
    )

    user.projects.create(
      name: 'Test Project'
    )

    other_user = User.create(
      first_name: 'Jane',
      last_name: 'Tester',
      email: 'jane@gmail.com'
    )

    other_project = other_user.projects.build(
      name: 'Test Project'
    )

    expect(other_project).to be_valid
  end
end
