require 'spec_helper'
require 'ff/profile'
require 'ff/profile_section.rb'
require 'ff/profiles'

describe FF::Profiles do
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
      '/some/path/to/profiles'
    )
  }

  subject {profile}

  it 'works' do
  end


  describe '#select' do
    it 'selects profiles by name' do
      expect(subject.select('default')).to be_instance_of(FF::Profile)
      expect(subject.select('default').name).to eql 'default'
    end

    it 'selects profiles by relative path' do
      expect(subject.select('bk1tdc15.default')).to be_instance_of(FF::Profile)
      expect(subject.select('bk1tdc15.default').name).to eql 'default'
    end

    it 'selects profiles by absolute path' do
      expect(subject.select('/some/path/to/profiles/bk1tdc15.default')).to be_instance_of(FF::Profile)
      expect(subject.select('/some/path/to/profiles/bk1tdc15.default').name).to eql 'default'
    end

    it 'selects profiles by default' do
      expect(subject.select).to be_instance_of(FF::Profile)
      expect(subject.select.name).to eql 'default'
    end

    context 'a missing profile by name' do
      it 'creates the profile' do
        pending
      end
    end

    context 'a missing profile by path' do
      it 'creates the profile' do
        pending
      end
    end
  end

  context 'with one default profile' do
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

  context 'without a default profile' do
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
