require 'spec_helper_acceptance'
require_relative './version.rb'

describe 'apache::mod::passenger class' do
  passenger_config_options = {
      'passenger_allow_encoded_slashes' => {type: 'OnOff', pass_opt: :PassengerAllowEncodedSlashes, context: 'server config, virtual host, directory, .htaccess'},
      'passenger_app_env' => {type: 'String', pass_opt: :PassengerAppEnv, context: 'server config, virtual host, directory, .htaccess'},
      'passenger_app_group_name' => {type: 'String', pass_opt: :PassengerAppGroupName, context: 'server config, virtual host, directory, .htaccess'},
      'passenger_app_root' => {type: 'FullPath', pass_opt: :PassengerAppRoot, context: 'server config, virtual host, directory, .htaccess'},
      'passenger_app_type' => {type: 'String', pass_opt: :PassengerAppType, context: 'server config, virtual host, directory, .htaccess'},
      'passenger_base_uri' => {type: 'URI', pass_opt: :PassengerBaseURI, context: 'server config, virtual host, directory, .htaccess'},
      'passenger_buffer_response' => {type: 'OnOff', pass_opt: :PassengerBufferResponse, context: 'server config, virtual host, directory, .htaccess'},
      'passenger_buffer_upload' => {type: 'OnOff', pass_opt: :PassengerBufferUpload, context: 'server config, virtual host, directory, .htaccess'},
      'passenger_concurrency_model' => {type: ["process", "thread"], pass_opt: :PassengerConcurrencyModel, context: 'server config, virtual host, directory, .htaccess'},
      'passenger_data_buffer_dir' => {type: 'FullPath', pass_opt: :PassengerDataBufferDir, context: 'server config'},
      'passenger_debug_log_file' => {type: 'String', pass_opt: :PassengerDebugLogFile, context: 'server config'},
      'passenger_debugger' => {type: 'OnOff', pass_opt: :PassengerDebugger, context: 'server config, virtual host, directory, .htaccess'},
      'passenger_default_group' => {type: 'String', pass_opt: :PassengerDefaultGroup, context: 'server config'},
      'passenger_default_ruby' => {type: 'FullPath', pass_opt: :PassengerDefaultRuby, context: 'server config'},
      'passenger_default_user' => {type: 'String', pass_opt: :PassengerDefaultUser, context: 'server config'},
      'passenger_disable_security_update_check' => {type: 'OnOff', pass_opt: :PassengerDisableSecurityUpdateCheck, context: 'server config'},
      'passenger_enabled' => {type: 'OnOff', pass_opt: :PassengerEnabled, context: 'server config, virtual host, directory, .htaccess'},
      'passenger_error_override' => {type: 'OnOff', pass_opt: :PassengerErrorOverride, context: 'server config, virtual host, directory, .htaccess'},
      'passenger_file_descriptor_log_file' => {type: 'FullPath', pass_opt: :PassengerFileDescriptorLogFile, context: 'server config'},
      'passenger_fly_with' => {type: 'FullPath', pass_opt: :PassengerFlyWith, context: 'server config'},
      'passenger_force_max_concurrent_requests_per_process' => {type: 'Integer', pass_opt: :PassengerForceMaxConcurrentRequestsPerProcess, context: 'server config, virtual host, directory, .htaccess'},
      'passenger_friendly_error_pages' => {type: 'OnOff', pass_opt: :PassengerFriendlyErrorPages, context: 'server config, virtual host, directory, .htaccess'},
      'passenger_group' => {type: 'String', pass_opt: :PassengerGroup, context: 'server config, virtual host, directory'},
      'passenger_high_performance' => {type: 'OnOff', pass_opt: :PassengerHighPerformance, context: 'server config, virtual host, directory, .htaccess'},
      'passenger_instance_registry_dir' => {type: 'FullPath', pass_opt: :PassengerInstanceRegistryDir, context: 'server config'},
      'passenger_load_shell_envvars' => {type: 'OnOff', pass_opt: :PassengerLoadShellEnvvars, context: 'server config, virtual host, directory, .htaccess'},
      'passenger_log_file' => {type: 'FullPath', pass_opt: :PassengerLogFile, context: 'server config'},
      'passenger_log_level' => {type: 'Integer', pass_opt: :PassengerLogLevel, context: 'server config'},
      'passenger_lve_min_uid' => {type: 'Integer', pass_opt: :PassengerLveMinUid, context: 'server config, virtual host'},
      'passenger_max_instances' => {type: 'Integer', pass_opt: :PassengerMaxInstances, context: 'server config, virtual host, directory, .htaccess'},
      'passenger_max_instances_per_app' => {type: 'Integer', pass_opt: :PassengerMaxInstancesPerApp, context: 'server config'},
      'passenger_max_pool_size' => {type: 'Integer', pass_opt: :PassengerMaxPoolSize, context: 'server config'},
      'passenger_max_preloader_idle_time' => {type: 'Integer', pass_opt: :PassengerMaxPreloaderIdleTime, context: 'server config, virtual host'},
      'passenger_max_request_queue_size' => {type: 'Integer', pass_opt: :PassengerMaxRequestQueueSize, context: 'server config, virtual host, directory, .htaccess'},
      'passenger_max_request_time' => {type: 'Integer', pass_opt: :PassengerMaxRequestTime, context: 'server config, virtual host, directory, .htaccess'},
      'passenger_max_requests' => {type: 'Integer', pass_opt: :PassengerMaxRequests, context: 'server config, virtual host, directory, .htaccess'},
      'passenger_memory_limit' => {type: 'Integer', pass_opt: :PassengerMemoryLimit, context: 'server config, virtual host, directory, .htaccess'},
      'passenger_meteor_app_settings' => {type: 'FullPath', pass_opt: :PassengerMeteorAppSettings, context: 'server config, virtual host, directory, .htaccess'},
      'passenger_min_instances' => {type: 'Integer', pass_opt: :PassengerMinInstances, context: 'server config, virtual host, directory, .htaccess'},
      'passenger_nodejs' => {type: 'FullPath', pass_opt: :PassengerNodejs, context: 'server config, virtual host, directory, .htaccess'},
      'passenger_pool_idle_time' => {type: 'Integer', pass_opt: :PassengerPoolIdleTime, context: 'server config'},
      'passenger_pre_start' => {type: 'URI', pass_opt: :PassengerPreStart, context: 'server config, virtual host'},
      'passenger_python' => {type: 'FullPath', pass_opt: :PassengerPython, context: 'server config, virtual host, directory, .htaccess'},
      'passenger_resist_deployment_errors' => {type: 'OnOff', pass_opt: :PassengerResistDeploymentErrors, context: 'server config, virtual host, directory, .htaccess'},
      'passenger_resolve_symlinks_in_document_root' => {type: 'OnOff', pass_opt: :PassengerResolveSymlinksInDocumentRoot, context: 'server config, virtual host, directory, .htaccess'},
      'passenger_response_buffer_high_watermark' => {type: 'Integer', pass_opt: :PassengerResponseBufferHighWatermark, context: 'server config'},
      'passenger_restart_dir' => {type: 'Path', pass_opt: :PassengerRestartDir, context: 'server config, virtual host, directory, .htaccess'},
      'passenger_rolling_restarts' => {type: 'OnOff', pass_opt: :PassengerRollingRestarts, context: 'server config, virtual host, directory, .htaccess'},
      'passenger_root' => {type: 'FullPath', pass_opt: :PassengerRoot, context: 'server config'},
      'passenger_ruby' => {type: 'FullPath', pass_opt: :PassengerRuby, context: 'server config, virtual host, directory, .htaccess'},
      'passenger_security_update_check_proxy' => {type: 'URI', pass_opt: :PassengerSecurityUpdateCheckProxy, context: 'server config'},
      'passenger_show_version_in_header' => {type: 'OnOff', pass_opt: :PassengerShowVersionInHeader, context: 'server config'},
      'passenger_socket_backlog' => {type: 'Integer', pass_opt: :PassengerSocketBacklog, context: 'server config'},
      'passenger_spawn_method' => {type: ["smart", "direct"], pass_opt: :PassengerSpawnMethod, context: 'server config, virtual host'},
      'passenger_start_timeout' => {type: 'Integer', pass_opt: :PassengerStartTimeout, context: 'server config, virtual host, directory, .htaccess'},
      'passenger_startup_file' => {type: 'RelPath', pass_opt: :PassengerStartupFile, context: 'server config, virtual host, directory, .htaccess'},
      'passenger_stat_throttle_rate' => {type: 'Integer', pass_opt: :PassengerStatThrottleRate, context: 'server config'},
      'passenger_sticky_sessions' => {type: 'OnOff', pass_opt: :PassengerStickySessions, context: 'server config, virtual host, directory, .htaccess'},
      'passenger_sticky_sessions_cookie_name' => {type: 'String', pass_opt: :PassengerStickySessionsCookieName, context: 'server config, virtual host, directory, .htaccess'},
      'passenger_thread_count' => {type: 'Integer', pass_opt: :PassengerThreadCount, context: 'server config, virtual host, directory, .htaccess'},
      'passenger_use_global_queue' => {type: 'String', pass_opt: :PassengerUseGlobalQueue, context: 'server config'},
      'passenger_user' => {type: 'String', pass_opt: :PassengerUser, context: 'server config, virtual host, directory'},
      'passenger_user_switching' => {type: 'OnOff', pass_opt: :PassengerUserSwitching, context: 'server config'},
      'rack_auto_detect' => {type: 'String', pass_opt: :RackAutoDetect, context: 'server config'},
      'rack_autodetect' => {type: 'String', pass_opt: :RackAutoDetect, context: 'server config'},
      'rack_base_uri' => {type: 'String', pass_opt: :RackBaseURI, context: 'server config'},
      'rack_env' => {type: 'String', pass_opt: :RackEnv, context: 'server config, virtual host, directory, .htaccess'},
      'rails_allow_mod_rewrite' => {type: 'String', pass_opt: :RailsAllowModRewrite, context: 'server config'},
      'rails_app_spawner_idle_time' => {type: 'String', pass_opt: :RailsAppSpawnerIdleTime, context: 'server config'},
      'rails_auto_detect' => {type: 'String', pass_opt: :RailsAutoDetect, context: 'server config'},
      'rails_autodetect' => {type: 'String', pass_opt: :RailsAutoDetect, context: 'server config'},
      'rails_base_uri' => {type: 'String', pass_opt: :RailsBaseURI, context: 'server config'},
      'rails_default_user' => {type: 'String', pass_opt: :RailsDefaultUser, context: 'server config'},
      'rails_env' => {type: 'String', pass_opt: :RailsEnv, context: 'server config, virtual host, directory, .htaccess'},
      'rails_framework_spawner_idle_time' => {type: 'String', pass_opt: :RailsFrameworkSpawnerIdleTime, context: 'server config'},
      'rails_ruby' => {type: 'String', pass_opt: :RailsRuby, context: 'server config'},
      'rails_spawn_method' => {type: 'String', pass_opt: :RailsSpawnMethod, context: 'server config'},
      'rails_user_switching' => {type: 'String', pass_opt: :RailsUserSwitching, context: 'server config'},
      'wsgi_auto_detect' => {type: 'String', pass_opt: :WsgiAutoDetect, context: 'server config'},
  }
  case fact('osfamily')
  when 'Debian'
    conf_file = "#{$mod_dir}/passenger.conf"
    load_file = "#{$mod_dir}/zpassenger.load"

    case fact('operatingsystem')
    when 'Ubuntu'
      case fact('lsbdistrelease')
      when '10.04'
        passenger_root = '/usr'
        passenger_ruby = '/usr/bin/ruby'
      when '12.04'
        passenger_root = '/usr'
        passenger_ruby = '/usr/bin/ruby'
      when '14.04'
        passenger_root         = '/usr/lib/ruby/vendor_ruby/phusion_passenger/locations.ini'
        passenger_ruby         = '/usr/bin/ruby'
        passenger_default_ruby = '/usr/bin/ruby'
      when '16.04'
        passenger_root         = '/usr/lib/ruby/vendor_ruby/phusion_passenger/locations.ini'
        passenger_ruby         = '/usr/bin/ruby'
        passenger_default_ruby = '/usr/bin/ruby'
      else
        # This may or may not work on Ubuntu releases other than the above
        passenger_root = '/usr'
        passenger_ruby = '/usr/bin/ruby'
      end
    when 'Debian'
      case fact('lsbdistcodename')
      when 'wheezy'
        passenger_root = '/usr'
        passenger_ruby = '/usr/bin/ruby'
      when 'jessie'
        passenger_root         = '/usr/lib/ruby/vendor_ruby/phusion_passenger/locations.ini'
        passenger_ruby         = '/usr/bin/ruby'
        passenger_default_ruby = '/usr/bin/ruby'
      else
        # This may or may not work on Debian releases other than the above
        passenger_root = '/usr'
        passenger_ruby = '/usr/bin/ruby'
      end
    end

    passenger_module_path = '/usr/lib/apache2/modules/mod_passenger.so'
    rackapp_user = 'www-data'
    rackapp_group = 'www-data'
  when 'RedHat'
    conf_file = "#{$mod_dir}/passenger.conf"
    load_file = "#{$mod_dir}/zpassenger.load"
    # sometimes installs as 3.0.12, sometimes as 3.0.19 - so just check for the stable part
    passenger_root = '/usr/lib/ruby/vendor_ruby/phusion_passenger/locations.ini'
    passenger_ruby = '/usr/bin/ruby'
    passenger_module_path = 'modules/mod_passenger.so'
    rackapp_user = 'apache'
    rackapp_group = 'apache'
  end

  pp_rackapp = <<-EOS
    /* a simple ruby rack 'hello world' app */
    file { '/var/www/passenger':
      ensure => directory,
      owner  => '#{rackapp_user}',
      group  => '#{rackapp_group}',
    }
    file { '/var/www/passenger/config.ru':
      ensure  => file,
      owner   => '#{rackapp_user}',
      group   => '#{rackapp_group}',
      content => "app = proc { |env| [200, { \\"Content-Type\\" => \\"text/html\\" }, [\\"hello <b>world</b>\\"]] }\\nrun app",
    }
    apache::vhost { 'passenger.example.com':
      port          => '80',
      docroot       => '/var/www/passenger/public',
      docroot_group => '#{rackapp_group}',
      docroot_owner => '#{rackapp_user}',
      require       => File['/var/www/passenger/config.ru'],
    }
    host { 'passenger.example.com': ip => '127.0.0.1', }
  EOS

  case fact('osfamily')
  when 'Debian'
    context "setting passenger options within the apache 'Directory' directive" do
     it 'should allow something with no error' do
       all_passenger_directory_options = passenger_config_options.select {|k,v| /directory/ =~ v[:context]}
       passenger_directory_options = ''
       all_passenger_directory_options.each do |k,v|
         passenger_directory_options << "'%s' => '%s',\n" % [k,'something']
       end
       pp = <<-EOS
       class { 'apache': service_ensure => stopped }
       class { 'apache::mod::passenger': }
       /* a simple ruby rack 'hello world' app */
       file { '/var/www/passenger':
         ensure => directory,
         owner  => '#{rackapp_user}',
         group  => '#{rackapp_group}',
       }
       file { '/var/www/passenger/config.ru':
         ensure  => file,
         owner   => '#{rackapp_user}',
            group   => '#{rackapp_group}',
            content => "app = proc { |env| [200, { \\"Content-Type\\" => \\"text/html\\" }, [\\"hello <b>world</b>\\"]] }\\nrun app",
          }
          apache::vhost { 'passenger.example.com':
            port          => '80',
            docroot       => '/var/www/passenger/public',
            docroot_group => '#{rackapp_group}',
            docroot_owner => '#{rackapp_user}',
            directories => [
               { 'path' => '/var/www/passenger',
                 #{passenger_directory_options}
               }     
            ],
            require       => File['/var/www/passenger/config.ru'],
          }
          host { 'passenger.example.com': ip => '127.0.0.1', }
          EOS
         apply_manifest(pp, :catch_failures => true)
      end
      describe file("#{$vhost_dir}/25-passenger.example.com.conf") do
        all_passenger_directory_options = passenger_config_options.select {|k,v| /directory/ =~ v[:context]}
        all_passenger_directory_options.each do |k,v|
          case v[:type]
            when 'QuotedString', 'RelPath', 'FullPath', 'Path'
             it { is_expected.to contain "#{v[:pass_opt]} \"something\"" }
            when 'String', 'URI', 'Integer'
              it { is_expected.to contain "#{v[:pass_opt]} something" }
            else
              it { is_expected.to contain "#{v[:pass_opt]} something" }
          end
        end
      end
     end
     context 'passenger config with passenger_installed_version set' do
       it 'should fail when an option is not valid for $passenger_installed_version' do
         pp = <<-EOS
         class { 'apache': }
         class { 'apache::mod::passenger':
           passenger_installed_version     => '4.0.0',
           passenger_instance_registry_dir => '/some/path/to/nowhere'
         }
         EOS
         apply_manifest(pp, :expect_failures => true) do |r|
           expect(r.stderr).to match(/passenger_instance_registry_dir is not introduced until version 5.0.0/)
         end
       end
       it 'should fail when an option is removed' do
         pp = <<-EOS
         class { 'apache': }
         class { 'apache::mod::passenger':
           passenger_installed_version => '5.0.0',
           rails_autodetect            => 'on'
         }
         EOS
         apply_manifest(pp, :expect_failures => true) do |r|
           expect(r.stderr).to match(/REMOVED PASSENGER OPTION/)
         end
       end
       it 'should warn when an option is deprecated' do
         pp = <<-EOS
         class { 'apache': }
         class { 'apache::mod::passenger':
           passenger_installed_version => '5.0.0',
           rails_ruby                  => '/some/path/to/ruby'
         }
         EOS
         apply_manifest(pp, :catch_failures => true) do |r|
           expect(r.stderr).to match(/DEPRECATED PASSENGER OPTION/)
         end
       end
    end
    context "default passenger config" do
      it 'succeeds in puppeting passenger' do
        pp = <<-EOS
          /* stock apache and mod_passenger */
          class { 'apache': }
          class { 'apache::mod::passenger': }
          #{pp_rackapp}
        EOS
        apply_manifest(pp, :catch_failures => true)
      end

      describe service($service_name) do
        if (fact('operatingsystem') == 'Debian' && fact('operatingsystemmajrelease') == '8')
          pending 'Should be enabled - Bug 760616 on Debian 8'
        else
          it { should be_enabled }
        end
        it { is_expected.to be_running }
      end

      describe file(conf_file) do
        it { is_expected.to contain "PassengerRoot \"#{passenger_root}\"" }

        case fact('operatingsystem')
        when 'Ubuntu'
          case fact('lsbdistrelease')
          when '10.04'
            it { is_expected.to contain "PassengerRuby \"#{passenger_ruby}\"" }
            it { is_expected.not_to contain "/PassengerDefaultRuby/" }
          when '12.04'
            it { is_expected.to contain "PassengerRuby \"#{passenger_ruby}\"" }
            it { is_expected.not_to contain "/PassengerDefaultRuby/" }
          when '14.04'
            it { is_expected.to contain "PassengerDefaultRuby \"#{passenger_ruby}\"" }
            it { is_expected.not_to contain "/PassengerRuby/" }
          when '16.04'
            it { is_expected.to contain "PassengerDefaultRuby \"#{passenger_ruby}\"" }
            it { is_expected.not_to contain "/PassengerRuby/" }
          else
            # This may or may not work on Ubuntu releases other than the above
            it { is_expected.to contain "PassengerRuby \"#{passenger_ruby}\"" }
            it { is_expected.not_to contain "/PassengerDefaultRuby/" }
          end
        when 'Debian'
          case fact('lsbdistcodename')
          when 'wheezy'
            it { is_expected.to contain "PassengerRuby \"#{passenger_ruby}\"" }
            it { is_expected.not_to contain "/PassengerDefaultRuby/" }
          when 'jessie'
            it { is_expected.to contain "PassengerDefaultRuby \"#{passenger_ruby}\"" }
            it { is_expected.not_to contain "/PassengerRuby/" }
          else
            # This may or may not work on Debian releases other than the above
            it { is_expected.to contain "PassengerRuby \"#{passenger_ruby}\"" }
            it { is_expected.not_to contain "/PassengerDefaultRuby/" }
          end
        end
      end

      describe file(load_file) do
        it { is_expected.to contain "LoadModule passenger_module #{passenger_module_path}" }
      end

      it 'should output status via passenger-memory-stats' do
        shell("PATH=/usr/bin:$PATH /usr/sbin/passenger-memory-stats") do |r|
          expect(r.stdout).to match(/Apache processes/)
          expect(r.stdout).to match(/Nginx processes/)
          expect(r.stdout).to match(/Passenger processes/)

          # passenger-memory-stats output on newer Debian/Ubuntu verions do not contain
          # these two lines
          unless ((fact('operatingsystem') == 'Ubuntu' && fact('operatingsystemrelease') == '14.04') or
                 (fact('operatingsystem') == 'Ubuntu' && fact('operatingsystemrelease') == '16.04') or
                 (fact('operatingsystem') == 'Debian' && fact('operatingsystemmajrelease') == '8'))
            expect(r.stdout).to match(/### Processes: [0-9]+/)
            expect(r.stdout).to match(/### Total private dirty RSS: [0-9\.]+ MB/)
          end

          expect(r.exit_code).to eq(0)
        end
      end

      # passenger-status fails under stock ubuntu-server-12042-x64 + mod_passenger,
      # even when the passenger process is successfully installed and running
      unless fact('operatingsystem') == 'Ubuntu' && fact('operatingsystemrelease') == '12.04'
        it 'should output status via passenger-status' do
          # xml output not available on ubunutu <= 10.04, so sticking with default pool output
          shell("PATH=/usr/bin:$PATH /usr/sbin/passenger-status") do |r|
            # spacing may vary
            expect(r.stdout).to match(/[\-]+ General information [\-]+/)
            if fact('operatingsystem') == 'Ubuntu' && fact('operatingsystemrelease') == '14.04' or
               (fact('operatingsystem') == 'Ubuntu' && fact('operatingsystemrelease') == '16.04') or
               fact('operatingsystem') == 'Debian' && fact('operatingsystemmajrelease') == '8'
              expect(r.stdout).to match(/Max pool size[ ]+: [0-9]+/)
              expect(r.stdout).to match(/Processes[ ]+: [0-9]+/)
              expect(r.stdout).to match(/Requests in top-level queue[ ]+: [0-9]+/)
            else
              expect(r.stdout).to match(/max[ ]+= [0-9]+/)
              expect(r.stdout).to match(/count[ ]+= [0-9]+/)
              expect(r.stdout).to match(/active[ ]+= [0-9]+/)
              expect(r.stdout).to match(/inactive[ ]+= [0-9]+/)
              expect(r.stdout).to match(/Waiting on global queue: [0-9]+/)
            end

            expect(r.exit_code).to eq(0)
          end
        end
      end

      it 'should answer to passenger.example.com' do
        shell("/usr/bin/curl passenger.example.com:80") do |r|
          expect(r.stdout).to match(/^hello <b>world<\/b>$/)
          expect(r.exit_code).to eq(0)
        end
      end

    end
  end
end
