module TripIt
  class TpDateTime < Base
    attr_reader :date, :time
    
    def initialize(rubyDT)
      return if rubyDT.nil?
      @date = rubyDT.strftime("%Y-%m-%d")
      @time = rubyDT.strftime("%H:%M:%S")
    end
  end
end