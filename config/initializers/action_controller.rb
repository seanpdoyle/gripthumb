ActiveSupport.on_load :action_controller_base do
  ActionController::Parameters.include(Module.new {
    def rewrite(key, &block)
      merge(key => block.call(self[key]))
    end
  })
end
