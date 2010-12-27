require 'json'
require 'erb'

module JvmGcGraph

  class Runner
    
    def self.run(file, output)
      pml = JvmGcGraph::ParseMemoryLog.new(file)
      puts pml.json.inspect
    end

    def output
      template = File.read(file)
      result = ERB.new(template).result(binding)
    end
  end

  class ParseMemoryLog

    GC_REGEX       = /^(([0-9]|\.)*):\s\[(GC\s([0-9]*)K->([0-9]*)K\(([0-9]*)K\)),\s(([0-9]|\.)*).*\]/
    FULL_GC_REGEX  = /^(([0-9]|\.)*):\s\[(Full GC\s([0-9]*)K->([0-9]*)K\(([0-9]*)K\)),\s(([0-9]|\.)*).*\]/
    ANY_GC_REGEX   = /^(([0-9]|\.)*):\s\[((Full )?GC\s([0-9]*)K->([0-9]*)K\(([0-9]*)K\)),\s(([0-9]|\.)*).*\]/

    attr_accessor :lines, :start_time, :data

    def initialize(log_file)
      File.open(log_file, "r") do |f|
        @lines = f.readlines
      end
      puts @lines.last
      if m = @lines.last.match(ANY_GC_REGEX)
        @start_time = Time.now.to_i - m[0].to_f
      end
      puts @start_time
      @data = []
    end

    def parse_lines
      lines.each do |line|
        if m = line.match(GC_REGEX)
          @data << [((@start_time + m[0].to_i)*1000), m[4], nil,nil]
        elsif m = line.match(FULL_GC_REGEX)
          puts "must be FULL: #{line}"
        end
      end
    end

    def json
      parse_lines
      @data.to_json
    end
    
  end

end
