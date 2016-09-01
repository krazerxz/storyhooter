# StoryHooter

StoryHooter is a real-time user generated branching story inspired by games like Consequences and Mad Libs. The story begins from a single line, ‘Once upon a time’. As people hear about it they can add to the story. Who you share your referral link with determines how the story continues. Because any number of people can add to the story at any given point the narrative quickly branches into an infinite number of endings.

Check out the [live site](http://storyhooter.chrispomfret.com/user/new?referred_from=692bac7079) to see it in action.

## How

StoryHooter uses the graph database [Neo4j](http://neo4jrb.readthedocs.io/en/7.1.x/) for storage which is also required for testing. Install that, put your connection url in config/neo4j_database.yml and you're good to go!
