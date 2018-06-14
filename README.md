## AtpDataElixir

Hosted here, on Heroku:
https://tennis-earnings.herokuapp.com/


## Why?

This project is about tennis. I'll always hold tennis very close to my heart.
The sport has helped me grow in many aspects of life. You learn a lot when
playing tennis, about people, about yourself.

This project shows the discrepancy between earnings in the ATP tennis circuit.
We gather data from the [list of currently ranked singles
players](http://www.atpworldtour.com/en/rankings/singles) in the ATP (for the
current season) and display the most recent amount for each of the players on
the list.

The idea of scraping career earnings from the ATP website was my first
programming project. I'v rewritten it in multiple languages. This particular
one uses Elixir and does have some more parts added to it, rather than only
displaying the name and amount as my original project was. Good times :)

I wanted to share this project because I saw Fernando Meligeni (a retired
player I follow on LinkedIn) mention a documentary series called ["Lejos de las
Luces"](https://www.youtube.com/channel/UC_J3DrSWxG2EJpLD3gVXI9w). A rough
translation could be "Away from the Spotlight". I highly suggest the
documentary even if you are a non-speaker. The captions are fairly good.
Here is the first [episode](www.youtube.com/watch?v=0d4S611Z1h0&t=1s).
The documentary highlights the struggles of different tennis players to
make it in the professional tour. It is a very competitive scene.
You can see the how the earnings are spread if you go to [the live
app](https://tennis-earnings.herokuapp.com/).


## Tech used

This app is written in Elixir, uses Phoenix to handle web requests,
Postgres to persist the data and Chart.js to create the charts.
