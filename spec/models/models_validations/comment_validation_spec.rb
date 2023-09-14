# frozen_string_literal: true

require 'rails_helper'

describe Comment, type: :model do
  it { should validate_length_of(:description).is_at_most(1000).is_at_least(10) }
end
