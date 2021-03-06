#
# Indicate intention to attend / regrets for meeting
#

if @action == 'regrets'
  message = "Regrets for the meeting."
else
  message = "I plan to attend the meeting."
end

AgendaCache.update(@agenda, message) do |agenda|

  directors = agenda[/^ +Directors.*?:\n\n.*?\n\n +Directors.*?:\n\n.*?\n\n/m]
  officers = agenda[/^ +Executive.*?:\n\n.*?\n\n +Executive.*?:\n\n.*?\n\n/m]
  guests = agenda[/^ +Guests.*?:\n\n.*?\n\n/m]

  if directors.include? @name

    updated = directors.sub /^ .*#{@name}.*?\n/, ''

    if @action == 'regrets'
      updated[/Absent:\n\n.*?\n()\n/m, 1] = "        #{@name}\n"
      updated.sub! /:\n\n +none\n/, ":\n\n"
      updated.sub! /Present:\n\n\n/, "Present:\n\n        none\n\n"
    else
      updated[/Present:\n\n.*?\n()\n/m, 1] = "        #{@name}\n"
      updated.sub! /Absent:\n\n\n/, "Absent:\n\n        none\n\n"

      # sort Directors
      updated.sub!(/Present:\n\n(.*?)\n\n/m) do |match|
        before=$1
        after=before.split("\n").sort_by {|name| name.split.rotate(-1)}
        match.sub(before, after.join("\n"))
      end
    end

    agenda.sub! directors, updated

  elsif officers.include? @name

    updated = officers.sub /^ .*#{@name}.*?\n/, ''

    if @action == 'regrets'
      updated[/Absent:\n\n.*?\n()\n/m, 1] = "        #{@name}\n"
      updated.sub! /:\n\n +none\n/, ":\n\n"
      updated.sub! /Present:\n\n\n/, "Present:\n\n        none\n\n"
    else
      updated[/Present:\n\n.*?\n()\n/m, 1] = "        #{@name}\n"
      updated.sub! /Absent:\n\n\n/, "Absent:\n\n        none\n\n"
    end

    agenda.sub! officers, updated

  elsif @action == 'regrets'

    updated = guests.sub /^ .*#{@name}.*?\n/, ''
    updated.sub! /:\n\n\n/, ":\n\n        none\n"

    agenda.sub! guests, updated

  elsif not guests.include? @name

    updated = guests.sub /\n\Z/, "\n        #{@name}\n"
    updated.sub! /:\n\n +none\n/, ":\n\n"

    agenda.sub! guests, updated

  end

  agenda
end
