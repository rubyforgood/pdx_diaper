# https://github.com/activeadmin/activeadmin/issues/3529
# Corrects weird behavior of date ranges

module ActiveAdmin
  module Inputs
    module Filters
      class DateRangeInput < ::Formtastic::Inputs::StringInput
        def lt_input_name
          "#{method}_lteqdate"
        end
      end
    end
  end
end
Ransack.configure do |config|
  config.add_predicate 'lteqdate',
    arel_predicate: 'lt',
    formatter: -> (v) { v + 1.day }
end