# coding: utf-8
require File.expand_path(__dir__ + '/spec_helper')

describe Fluent::MeCabOutput do
  let(:fluentd) { Fluent::Test::TestDriver.new(described_class) }
  let(:config){ %[
  type mecab
]
  }
  let(:conf){fluentd.configure(config).instance}

  describe '#configure' do
    context 'success' do
      it 'default' do
        expect(conf.parse_type).to eq("default")
      end
    end

    context 'fail' do
      let(:config){
        %[
  type mecab
  parse_type hoge
]
      }

      it 'wakati' do
        expect(conf.parse_type).to eq("hoge")
      end
    end
  end

  describe '#parse' do
    let(:jp) { "こんにちは世界" }
    let(:en) { "hello, world!?@#$%^&*()" }

    let(:mecab){ fluentd.configure(config).instance }
    let(:result_jp){[{"word"=>"こんにちは", "part_of_speech"=>"感動詞", "part_of_speech_subclassification1"=>"*", "part_of_speech_subclassification2"=>"*", "part_of_speech_subclassification3"=>"*", "inflected_forms"=>"*", "utilizing_types"=>"*", "original_word"=>"こんにちは", "reading"=>"コンニチハ", "pronunciation"=>"コンニチワ"}, {"word"=>"世界", "part_of_speech"=>"名詞", "part_of_speech_subclassification1"=>"一般", "part_of_speech_subclassification2"=>"*", "part_of_speech_subclassification3"=>"*", "inflected_forms"=>"*", "utilizing_types"=>"*", "original_word"=>"世界", "reading"=>"セカイ", "pronunciation"=>"セカイ"}]}
    let(:result_en){[{"word"=>"hello", "part_of_speech"=>"名詞,固有名詞", "part_of_speech_subclassification1"=>"組織", "part_of_speech_subclassification2"=>"*", "part_of_speech_subclassification3"=>"*", "inflected_forms"=>"*", "utilizing_types"=>"*"}, {"word"=>"world", "part_of_speech"=>"名詞,一般", "part_of_speech_subclassification1"=>"*", "part_of_speech_subclassification2"=>"*", "part_of_speech_subclassification3"=>"*", "inflected_forms"=>"*", "utilizing_types"=>"*"}]}
    it 'parse japanese' do
      mecab.parse(jp)
      expect(mecab.parse(jp)).to eq(result_jp)
    end

    it 'parse english' do
      expect(mecab.parse(en)).to eq(result_en)
    end
  end
end
