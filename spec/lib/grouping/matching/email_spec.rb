require 'spec_helper'
require 'grouping/matching/email'


RSpec.describe 'Grouping::Matching::Email' do
  describe '#match' do

    let(:matched_email) { 'johns@home.com' }
    let(:input) {"John,Smith,(555) 123-4567,#{matched_email},94105" }

      subject { Grouping::Matching::Email.match(input: input) }

      context 'Success' do

        it 'returns an Array' do
          expect(subject).to be_a Array
        end

        it 'returns the matched emails' do
          expect(subject).to eq [matched_email]
        end

        context 'when there are multiple emails' do

          let(:matched_email) { 'janed@home.com,johns@home.com' }

          it 'returns multiple matched emails' do
            expect(subject).to eq matched_email.split(',')
          end
        end # context 'when there are multiple emails'


        context 'when a block is passed' do

          subject { Grouping::Matching::Email.match(input: input){ puts 'blah' } }

          it 'yeilds control to the block' do
            expect { |b| Grouping::Matching::Email.match(input: input, &b) }.to yield_control
          end
        end # context 'when a block is passed'
    end # context 'Success'

    context 'when no matches are found' do
    
      let(:input) {"John,Smith,(555) 123-4567,unmatched_email,94105" }

      context 'when a block is passed' do

        subject { Grouping::Matching::Email.match(input: input){ puts 'blah' } }

        it 'does not yeild control to the block' do
          expect { |b| Grouping::Matching::Email.match(input: input, &b) }.not_to yield_control
        end
      end # context 'when a block is passed'
    end # context 'Error'

  end # describe '#match'
end
