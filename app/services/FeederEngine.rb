class FeederEngine
 def self.unsubscribe
   body, ok = SuperfeedrEngine::Engine.unsubscribe(@feed)
 end

 def self.subscribe
   body, ok = SuperfeedrEngine::Engine.subscribe(@feed)
 end

end