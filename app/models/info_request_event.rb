# == Schema Information
# Schema version: 27
#
# Table name: info_request_events
#
#  id              :integer         not null, primary key
#  info_request_id :integer         not null
#  event_type      :text            not null
#  params_yaml     :text            not null
#  created_at      :datetime        not null
#

# models/info_request_event.rb:
#
# Copyright (c) 2007 UK Citizens Online Democracy. All rights reserved.
# Email: francis@mysociety.org; WWW: http://www.mysociety.org/
#
# $Id: info_request_event.rb,v 1.9 2008-02-01 15:27:49 francis Exp $

class InfoRequestEvent < ActiveRecord::Base
    belongs_to :info_request
    validates_presence_of :info_request

    validates_presence_of :event_type
    validates_inclusion_of :event_type, :in => [
        'sent', 
        'resent', 
        'followup_sent', 
        'followup_resent', 
        'edit_outgoing', # outgoing message edited in admin interface
        'manual', # you did something in the db by hand
        'response'
    ]

    # We store YAML version of parameters in the database
    def params=(params)
        self.params_yaml = params.to_yaml
    end
    def params
        YAML.load(self.params_yaml)
    end

end


