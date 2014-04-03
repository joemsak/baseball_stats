Given(/^that no stats exist$/) do
  @stats_csv = ''
end

Given(/^(?:that )?some stats exist$/) do
  @stats_csv = "playerID,yearID,league,teamID,G,AB,R,H,2B,3B,HR,RBI,SB,CS\n"
  @stats_csv << "aardsda01,2009,AL,SEA,73,200,0,180,0,0,0,0,0,0"
  @stats_csv << "aardsda01,2010,AL,SEA,73,200,0,180,0,0,0,0,0,0"
end

Given(/^that enough at\-bats exist for multiple players in date range$/) do
  step "some stats exist"
  @stats_csv << "\naardsda02,2009,AL,SEA,73,200,0,180,0,0,0,0,0,0"
  @stats_csv << "\naardsda02,2010,AL,SEA,73,200,0,190,0,0,0,0,0,0"
end
