ActiveSupport.on_load :action_controller_base do
  class ActionController::Parameters
    def rewrite(key, &block)
      merge(key => block.call(self[key]))
    end
  end
end
