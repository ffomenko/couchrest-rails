require File.dirname(__FILE__) + '/../../spec_helper'

describe CouchRestRails::Views do
  
  before :each do
    setup_foo_bars
    CouchRestRails.views_path = 'vendor/plugins/couchrest-rails/spec/mock/views'
  end
  
  after :all do
    cleanup_foo_bars
  end
  
  describe '#push' do
  
    it "should push the views in CouchRestRails.views_path to a design document for the specified database" do
      res = CouchRestRails::Database.delete('foo')
      res = CouchRestRails::Database.create('foo')
      res = CouchRestRails::Fixtures.load('foo')
      res = CouchRestRails::Views.push('foo')
      db = CouchRest.database(@foo_db_url)      
      db.view("#{@foo_db_name}/all")['rows'].size.should == 10
    end
    
    it "should replace existing views but issue a warning" do
      CouchRestRails::Tests.setup('foo')
      res = CouchRestRails::Views.push('foo')
      res.should =~ /overwriting/
    end
    
    it "should push the views in CouchRestRails.views_path to a design document for all databases if * is passed" do
      CouchRestRails::Tests.setup
      dbf = CouchRest.database(@foo_db_url)
      dbb = CouchRest.database(@bar_db_url)
      (dbf.view("#{@foo_db_name}/all")['rows'].size + dbb.view("#{@foo_db_name}/all")['rows'].size).should == 15
    end
  
  end
  
end