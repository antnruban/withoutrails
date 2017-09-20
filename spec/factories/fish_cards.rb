# frozen_string_literal: true

FactoryGirl.define do
  factory :fish_card do
    message     Faker::Lorem.word
    description Faker::Lorem.sentence
  end
end
