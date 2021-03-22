require 'spec_helper'
require 'grouping/matching/email'


RSpec.describe 'Grouping::Matching::Phone' do
  describe '#match' do

    let(:matched_phone) { '(555) 123-4567' }
    let(:input) {"John,Smith,#{matched_phone},johns@home.com,94105" }

      subject { Grouping::Matching::Phone.match(input: input) }

      context 'Success' do

        it 'returns an Array' do
          expect(subject).to be_a Array
        end

        it 'returns the matched phone numbers' do
          expect(subject).to eq [matched_phone]
        end

        context 'when there are multiple phone numbers' do

          let(:matched_phone) { '(555) 123-4567,1-946-782-1367' }

          it 'returns multiple matched phone numbers' do
            expect(subject).to eq matched_phone.split(',')
          end
        end # context 'when there are multiple phone numbers'


        context 'when a block is passed' do

          it 'yeilds control to the block' do
            expect { |b| Grouping::Matching::Phone.match(input: input, &b) }.to yield_control
          end
        end # context 'when a block is passed'

    end # context 'Success'

    context 'when no matches are found' do
    
      let(:input) {"John,Smith,unmatched_phone,johns@home.com,94105" }

      context 'when a block is passed' do

        subject { Grouping::Matching::Phone.match(input: input){ puts 'blah' } }

        it 'does not yeild control to the block' do
          expect { |b| Grouping::Matching::Phone.match(input: input, &b) }.not_to yield_control
        end
      end # context 'when a block is passed'
    end # context 'Error'

  end # describe '#match'
end
