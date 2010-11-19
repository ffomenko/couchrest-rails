module CouchRestRails
  module Report
    def self.included(base)
      class << base
        attr_accessor :database
        def use_database(db)
          db = [COUCHDB_CONFIG[:db_prefix], db.to_s, COUCHDB_CONFIG[:db_suffix]].join
          self.database = COUCHDB_SERVER.database(db)
        end
      end
    end
  end
end
