desc "List all members"
task member_list: :environment do
  Member.all.each do |member|
    puts "#{member.number}\t#{member.name}"
  end
end
