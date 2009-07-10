module AASM
  module SupportingClasses
    class Integers
      attr_accessor :hash
      def initialize
        self.hash = {}
      end
      
      def add_integer(state)
        self.hash[state.options[:integer]] = state.name
      end
      
      def [](name)
        by_state(name)
      end
      
      def by_state(name)
        self.hash.invert[name]
      end
      
      def by_integer(i)
        self.hash[i]
      end
      
      def setted?
        !self.hash.nil?
      end
      
    end
  end
end