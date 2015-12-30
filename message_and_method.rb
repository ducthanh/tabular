
class TeaClock
  attr_accessor :timer, :ui

  def initialize(minutes)
    self.ui = StdoUi.new
    self.timer = SleepTimer.new(minutes, ui)
    init_plugins
  end

  def init_plugins
    @plugin = []
    ::Plugin.constants.each do |name|
      @plugin << ::Plugin.const_get(name).new(self)
    end
  end

  def start
    timer.start
  end
end


SleepTimer = Struct.new(:minutes, :notifier) do
  def start
    sleep minutes * 60
    notifier.notify("Tea is ready")
  end
end

class StdoUi
  def notify(text)
    puts text
  end
end

module Plugin
  class Beep
    def initialize(tea_clock)
      tea_clock.ui.extend(UiWithBeep)
    end

    module UiWithBeep
      def notify(*)
        puts "BEEP!"
        super
      end
    end
  end
end

t = TeaClock.new(0.005).start