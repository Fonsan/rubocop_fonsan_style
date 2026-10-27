require 'rubocop'
require 'rubocop_fonsan_style'

RSpec.describe RubocopFonsanStyle do
  let(:root) { File.expand_path('..', __dir__) }

  %w[.rubocop.default.yml .rubocop.rails.yml .rubocop.rspec.yml .rubocop.all.yml].each do |file|
    describe file do
      subject(:config) { RuboCop::ConfigLoader.load_file(File.join(root, file)) }

      it 'only references cops that exist in the bundled RuboCop versions' do
        expect { config }.not_to raise_error
      end

      it 'decides every pending cop' do
        expect(config.pending_cops.map(&:name)).to be_empty
      end
    end
  end
end
