# KafkaPotion
[Demo link](https://drive.google.com/file/d/1NqLh3m7E-5ohFyqYtR32rb1XyCaPj5c7/view?usp=sharing)
## Setup
Split up your tmux window into 3 panes.
Do this in the pane 1.1
```bash
./startup
```
In one of the other two panes, do
```bash
iex -S mix
```
Assuming you have fish shell here.
In the third window, do
```bash
./sumnos 100
```
## What the scripts do?
### ./startup
Kills all running docker containers
Tries to start pods that are required(zookeeper, kafka).
Creates a topic `test` once kafka is up and running.
Opens up a CLI to send messages on.
### ./sumnos 100
Sends numbers from 1 to 100 to the tmux pane 1.1,
each of which are all published to the topic.
The consumer in our app running under `iex -S mix` works with it.
