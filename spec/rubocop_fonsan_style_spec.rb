require 'rubocop'
require 'rubocop_fonsan_style'

RSpec.describe RubocopFonsanStyle do
  let(:root) { File.expand_path('..', __dir__) }

  %w[.rubocop.default.yml .rubocop.rails.yml .rubocop.rspec.yml .rubocop.all.yml].each do |file|
    it "loads #{file} with only cops that exist in the bundled RuboCop versions" do
      expect { RuboCop::ConfigLoader.load_file(File.join(root, file)) }.not_to raise_error
    end
  end

  # Merged with RuboCop's defaults, so cops a gem bump adds that no file mentions show up as pending.
  it 'decides every pending cop across all plugins' do
    config = RuboCop::ConfigLoader.configuration_from_file(File.join(root, '.rubocop.all.yml'))
    expect(config.pending_cops.map(&:name)).to be_empty
  end
end
