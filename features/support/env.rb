require 'baseball_stats'

BaseballStats::DataSource.name_key = "playerID,birthYear,nameFirst,nameLast"
BaseballStats::DataSource.name_key << "\naardsda01,1900,Player,One"
BaseballStats::DataSource.name_key << "\naardsda02,1900,Player,Two"
BaseballStats::DataSource.name_key << "\nallenbr01,1900,Player,Three"
BaseballStats::DataSource.name_key << "\nallenbr02,1900,Player,Four"
BaseballStats::DataSource.name_key << "\nnlplaye01,1900,NL Player,One"
BaseballStats::DataSource.name_key << "\nnlplaye02,1900,NL Player,Two"
BaseballStats::DataSource.name_key << "\nnlplaye03,1900,NL Player,Three"
BaseballStats::DataSource.name_key << "\nalplaye01,1900,AL Player,One"
BaseballStats::DataSource.name_key << "\nalplaye02,1900,AL Player,Two"
BaseballStats::DataSource.name_key << "\nalplaye03,1900,AL Player,Three"

ORIGINAL_STDOUT = $stdout
$stdout = File.open('./tmp/stdout.txt', 'w+')

at_exit do
  $stdout = ORIGINAL_STDOUT
end
