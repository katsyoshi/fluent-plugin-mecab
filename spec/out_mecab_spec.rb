# coding: utf-8
require File.expand_path(__dir__ + '/spec_helper')

describe Fluent::MeCabOutput do
  let(:fluentd) { Fluent::Test::TestDriver.new(described_class) }
  let(:config){ %[
  type mecab
  key text
]
  }
  let(:conf){fluentd.configure(config).instance}

  describe '#configure' do
    context 'success' do
      it 'parse type' do
        expect(conf.parse_type).to eq("default")
      end

      it 'key' do
        expect(conf.key).to eq('text')
      end
    end

    context 'fail' do
      let(:config){
        %[
  type mecab
  parse_type hoge
  key hoge
]
      }

      it 'cannot run this parse type' do
        expect{conf}.to raise_error(Natto::MeCabError)
      end
    end
  end

  describe '#parse' do
    let(:jp) {
      {'text' => "こんにちは世界", 'not keys' => 'さようなら人生'}
    }
    let(:en) {
      {'text' => 'hello, world!?@#$%^&*()','not key' => 'good night, world!!'}
    }

    let(:mecab){ fluentd.configure(config).instance }
    context 'parse japanese' do
      let(:result_jp){
        [{"text" => [{"word"=>"こんにちは","part_of_speech"=>"感動詞","part_of_speech_subclassification1"=>"*","part_of_speech_subclassification2"=>"*","part_of_speech_subclassification3"=>"*","inflected_forms"=>"*","utilizing_types"=>"*","original_word"=>"こんにちは","reading"=>"コンニチハ","pronunciation"=>"コンニチワ"},{"word"=>"世界","part_of_speech"=>"名詞","part_of_speech_subclassification1"=>"一般","part_of_speech_subclassification2"=>"*","part_of_speech_subclassification3"=>"*","inflected_forms"=>"*","utilizing_types"=>"*","original_word"=>"世界","reading"=>"セカイ","pronunciation"=>"セカイ"}]}]
      }

      it 'single key' do
        expect(mecab.parse(jp)).to eq(result_jp)
      end
    end

    context 'parse english' do
      let(:result_en){
        [{"text"=>[{"word"=>"hello", "part_of_speech"=>"名詞", "part_of_speech_subclassification1"=>"固有名詞", "part_of_speech_subclassification2"=>"組織", "part_of_speech_subclassification3"=>"*", "inflected_forms"=>"*", "utilizing_types"=>"*", "original_word"=>"*"}, {"word"=>"world", "part_of_speech"=>"名詞", "part_of_speech_subclassification1"=>"一般", "part_of_speech_subclassification2"=>"*", "part_of_speech_subclassification3"=>"*", "inflected_forms"=>"*", "utilizing_types"=>"*", "original_word"=>"*"}]}]
      }
      it 'single key' do
        expect(mecab.parse(en)).to eq(result_en)
      end
    end
  end
end
