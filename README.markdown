Crm export Plugin for Fat Free CRM
============

Adds to user profile the possibility of export the contacts. In order to be able to proccess big datasets, it's implemented as a background job.

By now, csv format is supported, more are comming

Installation
============

The plugin can be installed by running:

    gem install fastercsv
    script/plugin install git://github.com/tobi/delayed_job.git
    script/generate delayed_job_migration
    rake db:migrate
    script/plugin install git://github.com/tractis/crm_export.git

Then restart your web server.

You can automate the background jobs actions in a different maner, see
this post for a complete how-to http://www.magnionlabs.com/2009/2/28/background-job-processing-in-rails-with-delayed_job

Copyright (c) 2010 by Tractis (https://www.tractis.com), released under the MIT License