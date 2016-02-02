#!./hraven org.jruby.Main

#
# Copyright 2013 Twitter, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Create all hRaven tables in HBase
#
# Run this script using the HBase "shell" command:
#
#     hbase [--config /path/to/hbase/conf] shell bin/create_table.rb
#
disable 'hraven.job_history'
snapshot 'hraven.job_history', 'hraven.job_history_snapshot'
clone_snapshot 'hraven.job_history_snapshot', 'hraven.job_history_ARCHIVE_2016_01'
delete_snapshot 'hraven.job_history_snapshot'
drop 'hraven.job_history'
create 'hraven.job_history', {NAME => 'i', COMPRESSION => 'LZO'}

disable 'hraven.job_history_task'
snapshot 'hraven.job_history_task', 'hraven.job_history_task_snapshot'
clone_snapshot 'hraven.job_history_task_snapshot', 'hraven.job_history_task_ARCHIVE_2016_01'
delete_snapshot 'hraven.job_history_task_snapshot'
drop 'hraven.job_history_task'
create 'hraven.job_history_task', {NAME => 'i', COMPRESSION => 'LZO'}

# job_history  (indexed) by jobId table contains 1 column family:
#   i:  job-level information specifically the rowkey into the 

disable 'hraven.job_history-by_jobId'
snapshot 'hraven.job_history-by_jobId', 'hraven.job_history-by_jobId_snapshot'
clone_snapshot 'hraven.job_history-by_jobId_snapshot', 'hraven.job_history-by_jobId_ARCHIVE_2016_01'
delete_snapshot 'hraven.job_history-by_jobId_snapshot'
drop 'hraven.job_history-by_jobId'
create 'hraven.job_history-by_jobId', {NAME => 'i', COMPRESSION => 'LZO'}

# job_history_app_version - stores all version numbers seen for a single app ID
#   i:  "info" -- version information
disable 'hraven.job_history_app_version'
snapshot 'hraven.job_history_app_version', 'hraven.job_history_app_version_snapshot'
clone_snapshot 'hraven.job_history_app_version_snapshot', 'hraven.job_history_app_version_ARCHIVE_2016_01'
delete_snapshot 'hraven.job_history_app_version_snapshot'
drop 'hraven.job_history_app_version'
create 'hraven.job_history_app_version', {NAME => 'i', COMPRESSION => 'LZO'}

disable 'hraven.job_history_raw'
snapshot 'hraven.job_history_raw', 'hraven.job_history_raw_snapshot'
clone_snapshot 'hraven.job_history_raw_snapshot', 'hraven.job_history_raw_ARCHIVE_2016_01__02'
delete_snapshot 'hraven.job_history_raw_snapshot'
drop 'hraven.job_history_raw'
#create 'hraven.job_history_raw', {NAME => 'i', DATA_BLOCK_ENCODING => 'FAST_DIFF', COMPRESSION => 'LZO', BLOOMFILTER => 'ROWCOL', BLOCKCACHE => false, TTL => 15778500, METADATA => {'ENCODE_ON_DISK' => 'true'}},
								 #{NAME => 'r', DATA_BLOCK_ENCODING => 'FAST_DIFF', VERSIONS => 1, COMPRESSION => 'LZO', BLOCKCACHE => false, TTL => 15778500, METADATA => {'ENCODE_ON_DISK' => 'true'}}								 
create 'hraven.job_history_raw', {NAME => 'i', COMPRESSION => 'LZO', BLOOMFILTER => 'ROWCOL', BLOCKCACHE => false, TTL => 15778500},
								 {NAME => 'r', VERSIONS => 1, COMPRESSION => 'LZO', BLOCKCACHE => false, TTL => 15778500}

# job_history_process - stores metadata about job history data loading process
#   i:  "info" -- process information
disable 'hraven.job_history_process'
snapshot 'hraven.job_history_process', 'hraven.job_history_process_snapshot'
clone_snapshot 'hraven.job_history_process_snapshot', 'hraven.job_history_process_ARCHIVE_2016_01'
delete_snapshot 'hraven.job_history_process_snapshot'
drop 'hraven.job_history_process'
create 'hraven.job_history_process', {NAME => 'i', VERSIONS => 10, COMPRESSION => 'LZO'}

# flow_queue - stores reference to each flow ID running on a cluster, reverse timestamp ordered
disable 'hraven.flow_queue'
snapshot 'hraven.flow_queue', 'hraven.flow_queue_snapshot'
clone_snapshot 'hraven.flow_queue_snapshot', 'hraven.flow_queue_ARCHIVE_2016_01'
delete_snapshot 'hraven.flow_queue_snapshot'
drop 'hraven.flow_queue'
create 'hraven.flow_queue', {NAME => 'i', VERSIONS => 3, COMPRESSION => 'LZO', BLOOMFILTER => 'ROW'}

# flow_event - stores events fired during pig job execution
disable 'hraven.flow_event'
snapshot 'hraven.flow_event', 'hraven.flow_event_snapshot'
clone_snapshot 'hraven.flow_event_snapshot', 'hraven.flow_event_ARCHIVE_2016_01'
delete_snapshot 'hraven.flow_event_snapshot'
drop 'hraven.flow_event'
create 'hraven.flow_event', {NAME => 'i', VERSIONS => 3, COMPRESSION => 'LZO', BLOOMFILTER => 'ROW'}

# graphite key mapping tables
disable 'hraven.graphite_key_mapping'
snapshot 'hraven.graphite_key_mapping', 'hraven.graphite_key_mapping_snapshot'
clone_snapshot 'hraven.graphite_key_mapping_snapshot', 'hraven.graphite_key_mapping_ARCHIVE_2016_01'
delete_snapshot 'hraven.graphite_key_mapping_snapshot'
drop 'hraven.graphite_key_mapping'
create 'hraven.graphite_key_mapping', {NAME => 'i'}

disable 'hraven.graphite_key_mapping_r'
snapshot 'hraven.graphite_key_mapping_r', 'hraven.graphite_key_mapping_r_snapshot'
clone_snapshot 'hraven.graphite_key_mapping_r_snapshot', 'hraven.graphite_key_mapping_r_ARCHIVE_2016_01'
delete_snapshot 'hraven.graphite_key_mapping_r_snapshot'
drop 'hraven.graphite_key_mapping_r'
create 'hraven.graphite_key_mapping_r', {NAME => 'i'}

exit