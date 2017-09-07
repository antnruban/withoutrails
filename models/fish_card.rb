# frozen_string_literal: true

class FishCard < ActiveRecord::Base
  before_create :hi
  after_create :bye

  def hi
    puts 'HI'
  end

  def bye
    puts 'BYE'
  end
end
