require 'json'
require 'erb'

module JvmGcGraph

  class Runner

    class << self
      def run(opts)
        pml = JvmGcGraph::ParseMemoryLog.new(opts)
        pml.json
        html = output(pml)
        if opts[:output].is_a?(IO)
          opts[:output].puts html
        else
          File.open(opts[:output],'w') {|f| f.write(html)}
        end
      end
      
      def output(parse_memory_log)
        file = File.join(File.dirname(__FILE__),'templates','gc_chart.html.erb')
        template = File.read(File.expand_path(file))
        erb = ERB.new(template)
        erb.result(parse_memory_log.get_binding)
      end
    end
  end

  class ParseMemoryLog

    GC_REGEX       = /^(([0-9]|\.)*):\s\[(GC\s([0-9]*)K->([0-9]*)K\(([0-9]*)K\)),\s(([0-9]|\.)*).*\]/
    FULL_GC_REGEX  = /^(([0-9]|\.)*):\s\[(Full GC\s([0-9]*)K->([0-9]*)K\(([0-9]*)K\)),\s(([0-9]|\.)*).*\]/
    ANY_GC_REGEX   = /^(([0-9]|\.)*):\s\[((Full )?GC\s([0-9]*)K->([0-9]*)K\(([0-9]*)K\)),\s(([0-9]|\.)*).*\]/

    attr_accessor :lines, :start_time, :data, :gc_data

    def initialize(opts)
      File.open(opts[:file], "r") do |f|
        @lines = f.readlines
      end
      if m = @lines.last.match(ANY_GC_REGEX)
        @start_time = Time.now.to_i - m[0].to_f
      end
      @data = []
      @gc_data = []
      self.class.send(:define_method, :title) {opts[:title]}
    end

    def parse_lines
      lines.each do |line|
        if m = line.match(GC_REGEX)
          add_gc_arrays(m)
        elsif m = line.match(FULL_GC_REGEX)
          # might want to do something different with Full GC
          add_gc_arrays(m)
        end
      end
    end

    def add_gc_arrays(matches)
      add_to_array(@data, matches[0].to_i,
                   [matches[4].to_f, nil,nil,
                    matches[5].to_f, nil,nil,
                    matches[6].to_f, nil,nil])
      add_to_array(@gc_data, matches[0].to_i, [(matches[7].to_f*1000), nil,nil])
    end

    def add_to_array(data_values, time, values)
      d = [((@start_time + time)*1000)]
      data_values << (d + values)
    end

    def json
      parse_lines
      @data
    end

    def get_binding
      binding
    end
  end

end
