require 'ff/arguments'

describe FF::Arguments do

  describe "#adjust" do
    it 'will ignore global flags' do
      expect(with_arguments(['--help']).adjust).to eql ['--help']
      expect(with_arguments(['-h']).adjust).to eql ['-h']
    end

    it 'will ignore valid commands' do
      expect(with_arguments(['help']).adjust).to eql ['help']
      expect(with_arguments(['help', 'about']).adjust).to eql ['help', 'about']
    end

    it 'will consider the first argument the profile if not a valid command' do
      expect(with_arguments(['github', 'create']).adjust).to eql ['--profile=github', 'create']
      expect(with_arguments(['github is the best', 'create']).adjust).to eql ['--profile=github is the best', 'create']
      expect(with_arguments(['--help', 'github', 'create']).adjust).to eql ['--help', '--profile=github', 'create']
    end
  end

  def with_arguments(a)
    FF::Arguments.new(a, ['help', 'about', 'create', 'start', 'destroy'])
  end
end
