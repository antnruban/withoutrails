# frozen_string_literal: true

module FishCards
  module Modules
    module SearchMethods
      def find!(id)
        object = find(id: id.to_i)
        return object if object

        raise RecordNotFound, "Record with id '#{id}' wasn\'t found."
      end
    end
  end
end
