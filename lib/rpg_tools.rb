module RPG_Tools 
   class << self
    def setup
      yield self
    end
   end
   
end
# reopen ActiveRecord and include all the above to make
# them available to all our models if they want it
require 'rpg_tools/engine' 