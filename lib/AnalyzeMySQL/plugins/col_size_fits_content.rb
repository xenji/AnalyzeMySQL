require 'AnalyzeMySQL/plugin/base'

class ColSizeFitsContent < AnalyzeMySQL::Plugin::Base
  def schema_ready(schema)
    puts "Received schema"
  end
end