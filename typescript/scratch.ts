type GameResult = {
  homeTeam: string;
  awayTeam: string;
  homeGoals: number;
  awayGoals: number;
  finished?: boolean;
};
const first: GameResult = {
  homeTeam: "Manchester United",
  awayTeam: "Real Madrid",
  homeGoals: 3,
  awayGoals: 2,
};
const second: GameResult = {
  homeTeam: "Real Madrid",
  awayTeam: "Manchester United",
  homeGoals: 1,
  awayGoals: 1,
  finished: false,
};
console.log(first, second);

type Output = string | number;
let name: Output = "Patrick";
let age: Output = 38;
console.log(name, age);
