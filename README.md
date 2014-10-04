# BaseballStats

This gem will show you the following stats:

1. Most improved batting average for a player in a given year
2. The slugging percentage for a given year and team
3. The Triple Crown Eligible players in each league for a given year

## Installation

```bash
git clone git@github.com:joemsak/baseball_stats.git
cd baseball_stats
gem build baseball_stats.gemspec
gem install baseball_stats-0.0.1.gem
```

## Usage

run `baseball_stats` after installation, and follow the on-screen instructions

see https://github.com/joemsak/baseball_stats/blob/master/src/Batting-07-12.csv for how to reference Teams by ID and note that it only has data for 2007 to 2012

## Testing

Assuming you ran `bundle` run `rake`
