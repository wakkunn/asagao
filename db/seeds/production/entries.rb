# coding: utf-8

%w(Taro Jiro Hana).each do |name|
  member = Member.find_by_name(name)
  0.upto(9) do |idx|
    entry = Entry.create(
    { author: member,
      title: "野球観戦#{idx}",
      body: "今晩は久しぶりに神宮で野球観戦。内野B席の上段に着席。\n先発はヤクルト館山、広島福井。5回までは0対0の投手戦で、ヤクルトはノーヒット。6回に試合が動き出し、2点先行されます。しかしその裏、畠山の満塁弾に宮本のソロで大逆転！\nしかし7回に押本が大乱調、栗原に満塁弾をお返しされてしまいました。",
      posted_at: 10.days.ago.advance(days: idx),
      status: %w(draft member_only public)[idx % 3]
    }, without_protection: true)
    
    if idx == 7 || idx == 8
      %w(John Mike Sophy).each do |name2|
        voter = Member.find_by_name(name2)
        voter.voted_entries << entry
      end
    end
  end
end
