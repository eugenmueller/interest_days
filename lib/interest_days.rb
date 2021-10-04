# frozen_string_literal: true

require_relative "interest_days/version"
require "interest_days/calculator"
require "interest_days/calculation/base"
require "interest_days/calculation/isda_act_360"
require "interest_days/calculation/isda_act_365"
require "interest_days/calculation/isda_30_e_360"

module InterestDays
  class Error < StandardError; end
  # Your code goes here...
end
