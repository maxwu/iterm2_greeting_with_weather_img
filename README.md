# iterm2 greeting with weather and image
Bash shell to show weather forecast and show random picture from given folder

## Introduction

To make use of Friday evening time and refresh shell, the script is added to be invoked by my .bash_profile with iTerm2. Each time when Cmd+T is pressed to fork a new terminal, it will show weather forecast and show a random picture from my given folder as a greeting. 

I made it to let the terminal show my daughters picture every time I open terminal to work :_)

## Usage

So far it just support one parameter. `$1` is the folder of picture files. Here is a screenshot of sample. It is recommend to add command into shell profile to make a happy greeting.

`./show_greeting_imgs.sh ~/Pictures/`

![](https://github.com/maxwu/iterm2_greeting_with_weather_img/raw/master/Iterm2_greeting_img_20170527_5.png)

Each time it will randomly pick up a picure from the given folder and show it inline with iTerm image extension protocol.

## Future Works

Would feel more comfortable to rewrite in Python and add cli options as fetch a random wall-paper from Bing. 


## Reference

[iTerm2 imgcat protocol](https://www.iterm2.com/documentation-images.html)