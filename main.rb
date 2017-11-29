require "nokogiri"

file_path = ARGV[0]
report_path = ARGV[1] || file_path + ".csv"

puts "## Opening file: #{file_path}"
doc = File.open(file_path) { |f| Nokogiri::XML(f) }

puts "## Starting parsing..."
ids = []
doc.xpath('//VariationData//Variants//Variant//VariantID').each do |id|
  puts id.content
  ids.push id
end

puts "## Generating the report..."
File.open(report_path, "w") do |f|
  data = ids.join(";")
  f.write(data)
end

puts "## Done"
exit 0
