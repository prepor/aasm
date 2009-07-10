require 'rubygems'
require 'active_record'

config = {'test' => {'adapter' => 'sqlite3', 'database' => ':memory:'}}
ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + "/debug.log")
ActiveRecord::Base.establish_connection(config['test'])



def rebuild_models
  ActiveRecord::Base.connection.create_table :maries, :force => true do |table|
    table.column :name, :string
    table.column :status, :integer
  end
  rebuild_classes
end

require File.join(File.dirname(__FILE__), '..', 'aasm')

def rebuild_classes
  Object.send(:remove_const, "Mary") rescue nil
  Object.const_set("Mary", Class.new(ActiveRecord::Base))
  Mary.class_eval do
    include AASM
    
    aasm_column :status
    
    aasm_initial_state :pending
    
    aasm_state :pending, :integer => 0
    aasm_state :started, :integer => 1  
    aasm_state :finished, :integer => 2 
                  
    aasm_event :start do
      transitions :to => :started, :from => [:pending]
    end
end

end