require 'spec_helper'
require 'grouping'


RSpec.describe 'Grouping::Group' do
  describe '#call' do

    let(:matching_type) { 'Email' }
    let(:input_basename_wo_ext) { 'input1' }
    let(:input_basename_ext) { 'csv' }
    let(:input_file) { "spec/fixtures/data/#{input_basename_wo_ext}.#{input_basename_ext}" }
    let(:output_file) { input_file.sub(/\./, '_output.') }

    subject { Grouping::Group.new }

    before(:each) do
      allow(subject).to receive(:call).and_call_original
      allow(subject).to receive(:write_output)
      allow(Grouping::Matching).to receive(:get_matching).and_call_original
      subject.call(input_file: input_file, matching_type: matching_type)
    end

    it 'calculaes the output location' do
      expect(subject).to have_received(:write_output).with(hash_including(output_file: output_file))
    end

    it 'delegaes to get the right matching type' do
      expect(Grouping::Matching).to have_received(:get_matching).with(hash_including(matching_type: matching_type))
    end

    describe '#do_grouping' do

      context 'when grouping by email' do

        let(:grouping) { 
          {"johns@home.com"=>1, "janes@home.com"=>7, "jacks@home.com"=>3, "joshs@home.com"=>4}
        }

        it 'identifies uniques emails in the input' do
          expect(subject).to have_received(:write_output).with(hash_including(grouping: grouping))
        end
      end # context 'when grouping by email'
          
      context 'when grouping by phone' do

        let(:matching_type) { 'Phone' }

        let(:grouping) { 
          {"(555) 123-4567"=>2, "444.123.4567"=>3, "(456) 789-0123"=>4, "1555654987"=>5, "1444123456"=>6}
        }


        it 'identifies uniques emails in the input' do
          expect(subject).to have_received(:write_output).with(hash_including(grouping: grouping))
        end
      end # context 'when grouping by email'
    end #describe 'do_grouping'


  end # describe '#call'
end

