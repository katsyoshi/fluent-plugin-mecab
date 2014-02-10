# coding: utf-8
require 'natto'

class MeCab
  def initialize(type, keys)
    @type = type
    opt = {}
    opt[:output_format_type] = @type unless type =~ /default/
    @mecab = Natto::MeCab.new(opt)
    @keys = keys
  end

  def parse(record)
    @keys.map do |key|
      {key => result_format(@mecab.parse(record[key]))}
    end
  end

  def result_format(result)
    case @type
    when /default/i
      strs = result.split(/\n/)
      strs.pop
      strs.map do|str|
        m = default(str)
        m ? Hash[m.names.zip(m.captures)] : nil
      end.compact
    when /chasen/i
      # TODO
    end
  end

  def default(str)
    base = "(?<word>.+)\t(?<part_of_speech>.+),(?<part_of_speech_subclassification1>.+),(?<part_of_speech_subclassification2>.+),(?<part_of_speech_subclassification3>.+),(?<inflected_forms>.+),(?<utilizing_types>.+),(?<original_word>.*)"
    # 表層形\t品詞,品詞細分類1,品詞細分類2,品詞細分類3,活用形,活用型,原形,読み,発音
    if str =~ /^\w/
      str.match(/#{base}/)
    else
      str.match(/#{base},(?<reading>.*),(?<pronunciation>.*)/)
    end
  end

  def chansen(str)
    # TODO
  end
end
