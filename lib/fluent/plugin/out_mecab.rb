# coding: utf-8
module Fluent
class MeCabOutput < Output
  Plugin.register_output('mecab', self)
  config_param :parse_type, :string, default: "default"

  def initialize
    super
    require 'fluent/plugin/mecab'
    @mecab = MeCab.new(@parse_type)
  end

  def configure(config)
    super
  end

  def start
    super
  end

  def shutdown
    super
  end

  def emit(tag, es, chain)
    es.each do |time, chain|
      Engine.emit(@tag, time, parse(record))
    end
  end

  def parse(str)
    @mecab.parse(str)
  end
end
end
