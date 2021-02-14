# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Note, type: :model do
  before do
    @user = User.create(
      first_name: 'karan',
      last_name: 'bhaydiya',
      email: 'karan@gmail.com'
    )

    @project = @user.projects.create(
      name: 'Test Project'
    )
  end

  it 'is valid with user, project and message' do
    note = Note.new(
      message: 'Test note',
      project: @project,
      user: @user
    )

    expect(note).to be_valid
  end

  it 'is invalid without a message' do
    note = Note.new(message: nil)
    note.valid?
    expect(note.errors[:message]).to include("can't be blank")
  end

  describe 'search message for term' do
    before do
      @note1 = @project.notes.create(
        message: 'This is the first note',
        user: @user
      )

      @note2 = @project.notes.create(
        message: 'This is the second note',
        user: @user
      )

      @note3 = @project.notes.create(
        message: 'First, preheat the oven',
        user: @user
      )
    end

    context 'when a match is found' do
      it 'return notes that the search term' do
        expect(Note.search('first')).to include(@note1, @note3)
      end
    end

    context 'when no match is found' do
      it 'return an empty collection' do
        expect(Note.search('message')).to be_empty
      end
    end
  end
end
