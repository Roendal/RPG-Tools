module RPG_Tools
  class Engine < Rails::Engine
=begin    
    initializer "rpg_tools.models.*whatever*" do
      ActiveSupport.on_load(:active_record) do
        include RPG_Tools::Models::Whatever
      end
    end
=end
  end
end