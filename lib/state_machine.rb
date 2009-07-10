require 'ostruct'

module AASM
  class StateMachine
    def self.[](*args)
      (@machines ||= {})[args]
    end

    def self.[]=(*args)
      val = args.pop
      (@machines ||= {})[args] = val
    end
    
    attr_accessor :states, :events, :initial_state, :config, :integers
    attr_reader :name
    
    def initialize(name)
      @name   = name
      @initial_state = nil
      @states = []
      @events = {}
      @config = OpenStruct.new
      @integers = AASM::SupportingClasses::Integers.new
    end

    def clone
      klone = super
      klone.states = states.clone
      klone
    end

    def create_state(name, options)
      unless @states.include?(name)
        state = AASM::SupportingClasses::State.new(name, options) 
        @states << state
        integers.add_integer(state) if state.options[:integer]
      end
    end
  end
end
