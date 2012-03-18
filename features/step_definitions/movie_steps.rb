# Add a declarative step here for populating the DB with movies.


Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  end
  # assert false, "Unimplmemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  arr_match = page.body.scan(/<tr>.+?<td>(.*?)<\/td>/m)
  assert_equal arr_match[arr_match.index([e1]) + 1], [e2]
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  # assert false, "Unimplmemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(',').each do |rating|
        step %Q{I #{uncheck}check "ratings_#{rating.strip}"}
  end
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
end

When /I (un)?check all ratings$/ do |uncheck|
  ratings = "PG, R, G, PG-13, NC-17"
  step %Q{I #{uncheck}check the following ratings: #{ratings}}
end

Then /I should see all of the movies$/ do
    step %Q{table "movies" have roles count 11}
end

Then /I should see none of the movies$/ do
    step %Q{table "movies" have roles count 1}
end
