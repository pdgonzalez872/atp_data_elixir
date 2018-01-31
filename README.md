# AtpDataElixir

[![Build Status](https://travis-ci.org/pdgonzalez872/atp_data_elixir.svg?branch=master)](https://travis-ci.org/pdgonzalez872/atp_data_elixir)

## Description

My go to project/script when learning a new language is fetching the career prize money for each ranked player
currently ranked in the ATP.

This was actually the first meaningful project I ever completed by leveraging programming.
It helped me win a couple of arguments I was having with people who thought tennis was a good source of income.
The idea was to show the massive drop off in prize money as the rankings go down. 

The project consists of the following steps:
- Go here: www.atpworldtour.com/en/rankings/singles?rankDate=2018-01-29&rankRange=1-5000&countryCode=all
- Get the url for each player in that list, eg: http://www.atpworldtour.com/en/players/fabio-fognini/f510/overview
- Visit each url and get some data points, most importantly the "Prize Money Singles & Doubles Combined"
- Use those to create a file, sort the file by `prize_money`
- Here is an example of the file: https://github.com/pdgonzalez872/atp_data_elixir/blob/master/test/test_data/data_files/20180131_rankings.txt

Here are links to each implementation:

| Language | Source |
|----------|--------|
| Python | https://github.com/pdgonzalez872/Mentor/blob/master/ATP_Stats_Refactor.py |
| Ruby | https://github.com/pdgonzalez872/atp_data |
| Elixir | https://github.com/pdgonzalez872/atp_data_elixir |

The latest and most efficient version of the Ruby implementation uses pools of `Threads`. I don't even remember writing it
anymore, but I run the code every once and a while to get the latest results.

My first implementation of Elixir used `Flow`, an abstraction of GenServer. It lets you control the number of `stages`
for optimal performance on your machine.

This has been a fun exercise, one that I collected a little bit of data about:

| Implementation Details | Time to finish the job (seconds) |
|----------|--------|
| Ruby, as of the latest commit, Threads, pool_size -> `10` | 159 |
|Elixir, Flow, without the `Flow.partition()` call| almost 300|
|Elixir, Flow, `Flow.partition()`| 211|
|Elixir, Flow, `Flow.partition(stages: 8)`| 155|
|Elixir, Flow, `Flow.partition(stages: 16)`| 179|
|Elixir, Flow, `Flow.partition(stages: 12)`| 179|
|Elixir, Flow, `Flow.partition(stages: 10)`| 177|
|Elixir, Flow, `Flow.partition(stages: 8)`| 162|
|Elixir, Flow, `Flow.partition(stages: 8)`| 167|

It seems that the constraints from both implementations become similar. It is probably
due to some hardware/network limitation or something that I don't quite understand at this time.

This has proven to be a good exercise in dealing with external libraries, some logic, tooling in Elixir,
a little introduction to the OTP tools and overall just a different way of solving a problem that is interesting to me.
