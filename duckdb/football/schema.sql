


CREATE TABLE league(homeTeam VARCHAR, awayTeam VARCHAR, homeGoals BIGINT, awayGoals BIGINT);

CREATE VIEW goals AS SELECT homeTeam, awayTeam, homeGoals, awayGoals, (homeGoals + awayGoals) AS goals FROM league;



