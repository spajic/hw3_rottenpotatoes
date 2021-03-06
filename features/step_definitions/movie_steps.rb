# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.    

    if !Movie.exists?(:title => movie['title'])
      Movie.new(movie).save
    end
  end
  # flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  pos1 = page.body.index(e1)
  pos2 = page.body.index(e2)
  pos1.should_not == nil
  pos2.should_not == nil
  (pos1 < pos2).should == true
  # flunk "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  ratings = rating_list.split(",")
  ratings.each {|r|
    rating_element_id = "ratings_" + r.gsub(" ", "")
    if uncheck != nil
      uncheck(rating_element_id)
    else
      check(rating_element_id)
    end
  }
end

Then /I should see all of the movies/ do
  Movie.all.count.should == all("table#movies tr").count - 1
end

Then /the director of "(.*)" should be "(.*)"/ do |movie, director|
  m = Movie.where(:title => movie).first
  m.director.should == director
end
