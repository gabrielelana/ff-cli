require 'spec_helper'
require 'ff/profiles'
require 'ff/profile'

describe FF::Profiles do
  context 'with one default profile' do
    let(:profile) {
      described_class.new(
        "
          [General]
          StartWithLastProfile=1

          [Profile0]
          Name=default
          IsRelative=1
          Path=bk1tdc15.default
          Default=1
        ",
        ['/some/path/to/profiles/bk1tdc15.default'],
        '/some/path/to/profiles'
      )
    }

    subject {profile}

    it { should have_default }

    describe '#default' do
      subject {profile.default}
      it 'gives the default profile' do
        expect(subject).to be_instance_of(FF::Profile)
        expect(subject.name).to eql 'default'
        expect(subject.path).to eql '/some/path/to/profiles/bk1tdc15.default'
      end
    end
  end

  context 'with one profile' do
    subject {
      described_class.new(
        "
          [General]
          StartWithLastProfile=0

          [Profile0]
          Name=default
          IsRelative=1
          Path=bk1tdc15.default
        ",
        ['/some/path/to/profiles/bk1tdc15.default'],
        '/some/path/to/profiles'
      )
    }

    it {should_not have_default}

    describe '#default' do
      it 'should raise an exception' do
        expect {subject.default}.to raise_error(FF::DefaultProfileNotFound)
      end
    end
  end
end
