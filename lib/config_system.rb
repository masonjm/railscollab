=begin
RailsCollab
-----------

Copyright (C) 2008 James S Urquhart (jamesu at gmail.com)

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
=end

require 'ostruct'
require 'yaml'

# Courtesy of Dmytro Shteflyuk's blog post
begin
	::ConfigOverride = OpenStruct.new(YAML.load_file("#{RAILS_ROOT}/config/config.override.yml"))
	env_config = ConfigOverride.send(RAILS_ENV)
	ConfigOverride.common.update(env_config) unless env_config.nil?
rescue Exception
	::ConfigOverride = OpenStruct.new()
end

::AppConfig = OpenStruct.new()

# Try loading gd2
begin
	require 'gd2'
	AppConfig.no_gd2 = false
rescue Exception
	AppConfig.no_gd2 = true
end

# Try loading AWS::S3
begin
	require 'aws/s3'
	AppConfig.no_s3 = false
rescue Exception
	AppConfig.no_s3 = true
end

