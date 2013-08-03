require File.expand_path(File.dirname(__FILE__) + '/../vendor/aws-sdk-ruby/samples/samples_config')

filename = "tabirepo" + Time.now.strftime('%Y%m%d%S%L') + ".dump.sql.gz"
def dump_tabirepo_database(filename)
  system(`mysqldump -utabirepo -pped0urwQmpiz2lDghui[ tabirepo_core | gzip > #{filename}`)
end

def upload_file_to(bucket, filename)
  # upload a file
  basename = File.basename(filename)
  obj = bucket.objects[filename]
  obj.write(:file => filename)
end

dump_tabirepo_database(filename)
s3 = AWS::S3.new
bucket = s3.buckets['db.backup.tabi-repo.net']
upload_file_to(bucket, filename)
File.delete(filename)
