desc "Generate the next event in an event series"
task :update_feed => :environment do
  puts "Updating event series..."
  EventSeries.update
  puts "done."
end