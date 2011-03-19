module TripIt
  class TpDateTime < Base
    attr_reader :date, :time
    
    def initialize(rubyDT)
      @date = rubyDT.strftime("%Y-%m-%d")
      @time = rubyDT.strftime("%H:%M:%S%Z")
    end
  end
end