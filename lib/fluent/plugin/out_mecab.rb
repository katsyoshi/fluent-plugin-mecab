# coding: utf-8
module Fluent
class MeCabOutput < Output
  Plugin.register_output('mecab', self)
  config_param :parse_type, :string, default: "default"
  config_param :tag, :string, default: "mecab"
  config_param :key, :string

  def initialize
    super
    require 'fluent/plugin/mecab'
  end

  def configure(config)
    super
    @mecab = MeCab.new(@parse_type, @key.split(',').map{|string| string.strip})
  end

  def start
    super
  end

  def shutdown
    super
  end

  def emit(tag, es, chain)
    es.each do |time, record|
      Engine.emit(@tag, time, parse(record))
    end
  end

  def parse(record)
    @mecab.parse(record)
  end
end
end
