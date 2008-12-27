require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe OneClick::Package do
  describe "#new" do
    it 'should fail if no name for the package was given' do
      lambda {
        OneClick::Package.new { }
      }.should raise_error(RuntimeError, /package name is required/)
    end

    it 'should fail if no version for the package was given' do
      lambda {
        OneClick::Package.new('foo') { }
      }.should raise_error(RuntimeError, /package version is required/)
    end

    it 'should not fail if both name and version for the package was given' do
      lambda {
        OneClick::Package.new('foo', '1.2.3') { }
      }.should_not raise_error(RuntimeError)
    end

    it 'should not attempt to define package if no block was provided' do
      lambda {
        OneClick::Package.new
      }.should_not raise_error(RuntimeError)
    end

    it 'should allow package name be accessed' do
      pkg = OneClick::Package.new('foo', '1.2.3')
      pkg.name.should == 'foo'
    end

    it 'should allow package version be accessed' do
      pkg = OneClick::Package.new('foo', '1.2.3')
      pkg.version.should == '1.2.3'
    end
  end

  describe '#actions' do
    before :each do
      @mock_actions = mock(OneClick::Package::Actions)
      OneClick::Package::Actions.stub!(:new).and_return(@mock_actions)
    end

    it 'should create an actions instance if a block was provided' do
      OneClick::Package::Actions.should_receive(:new)
      OneClick::Package.new('foo', '1.2.3') { }
    end

    it 'should delegate block to actions instance' do
      a_block = proc { }
      @mock_actions.should_receive(:instance_eval).with(&a_block)
      OneClick::Package.new('foo', '1.2.3', &a_block)
    end

    it 'should create a default actions instance if no block was provided' do
      OneClick::Package::Actions.should_receive(:new).and_return(@mock_actions)
      pkg = OneClick::Package.new('foo', '1.2.3')
      pkg.actions.should == @mock_actions
    end

    it 'should allow package actions be replaced later' do
      pkg = OneClick::Package.new('foo', '1.2.3')
      pkg.actions = nil
      pkg.actions.should be_nil
    end
  end

  describe '#pkg_dir' do
    before :each do
      @pkg = OneClick::Package.new('foo', '4.5.6')
    end

    it 'should use OneClick sandbox definition' do
      OneClick.should_receive(:sandbox_dir).and_return('something')
      @pkg.pkg_dir
    end

    it 'should define a folder structure using name and version' do
      OneClick.stub!(:sandbox_dir).and_return('something')
      @pkg.pkg_dir.should == 'something/foo/4.5.6'
    end
  end

  describe "#define" do
    predicate_matchers[:have_defined] = :task_defined?

    before :each do
      Rake.application.clear

      @mock_actions = mock(OneClick::Package::Actions)
      OneClick::Package::Actions.stub!(:new).and_return(@mock_actions)
      @pkg = OneClick::Package.new('foo', '4.5.6')
    end

    it 'should define a task for the package version' do
      Rake::Task.should_not have_defined('foo:4.5.6')
      @pkg.define
      Rake::Task.should have_defined('foo:4.5.6')
    end

    describe "#define_download" do
      before :each do
        @files = [{:file => 'foo-4.5.6.zip', :url => 'http://www.domain.com/foo-4.5.6.zip'}]
        OneClick.stub!(:sandbox_dir).and_return('tmp')
        @mock_actions.stub!(:has_downloads?).and_return(true)
        @mock_actions.stub!(:downloads).and_return(@files)
      end

      it 'should not define task if package has no downloads' do
        @mock_actions.should_receive(:has_downloads?).and_return(false)
        @pkg.define_download
        Rake::Task.should_not have_defined('foo:4.5.6:download')
      end

      it 'should define the package download task' do
        @mock_actions.should_receive(:has_downloads?).and_return(true)
        @mock_actions.should_receive(:downloads).and_return(@files)
        @pkg.define_download
        Rake::Task.should have_defined('foo:4.5.6:download')
      end

      it 'should define file tasks for each downloadable' do
        Rake::Task.should_not have_defined('tmp/foo/4.5.6/foo-4.5.6.zip')
        @pkg.define_download
        Rake::Task.should have_defined('tmp/foo/4.5.6/foo-4.5.6.zip')
      end

      it 'should make the file tasks part of the download one' do
        @pkg.define_download
        Rake::Task['foo:4.5.6:download'].prerequisites.should include('tmp/foo/4.5.6/foo-4.5.6.zip')
      end
    end
  end
end