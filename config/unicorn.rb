# Minimal sample configuration file for Unicorn (not Rack) when used
# with daemonization (unicorn -D) started in your working directory.
#
# See http://unicorn.bogomips.org/Unicorn/Configurator.html for complete
# documentation.
# See also http://unicorn.bogomips.org/examples/unicorn.conf.rb for
# a more verbose configuration using more features.

#listen 8080 # by default Unicorn listens on port 8080
#worker_processes 2 # this should be >= nr_cpus
#pid "/projects/tabirepo/shared/pids/unicorn.pid"
#stderr_path "/projects/tabirepo/shared/log/unicorn.log"
#stdout_path "/projects/tabirepo/shared/log/unicorn.log"

#listen '/projects/tabirepo/shared/sockets/unicorn.sock'
#pid '/projects/tabirepo/shared/pids/unicorn.pid'

listen '/tmp/unicorn.sock'
pid '/tmp/unicorn.pid'



