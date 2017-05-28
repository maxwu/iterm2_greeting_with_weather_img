# iterm2 greeting with weather and image
Bash shell to show weather forecast and show random picture from given folder

## Introduction

To make use of Friday evening time and refresh shell, the script is added to be invoked by my .bash_profile with iTerm2. Each time when Cmd+T is pressed to fork a new terminal, it will show weather forecast and show a random picture from my given folder as a greeting. 

I made it to let the terminal show my daughters picture every time I open terminal to work :_)

## Usage

It is recommend to add command into shell profile to make a happy greeting. Here is the line in my bash_profile on Mac, `~/devel/iterm2_greeting_with_weather_img/show_greeting_imgs.sh -c lower+hutt -p ~/Pictures/murphey-imgs/ -w 40`.

Below is a screenshot of sample of running in iTerm2 on Mac.
`./show_greeting_imgs.sh -p ~/Pictures/`
![](https://github.com/maxwu/iterm2_greeting_with_weather_img/raw/master/Iterm2_greeting_img_20170527_5.png)

☀ If current terminal window width is smaller than 100 cols, it will just show a daily weather forecast but does not show the full version of each 6 hr weather forecast.

♘ Each time it will randomly pick up a picure from the given folder and show it inline with iTerm image extension protocol. 
If no folder is specified, it will try ~/Pictures by default. In cases no file can be selected, imgcat step will be bypassed.

So far a few options are supported, `-h` will show full description.

```shell
./show_greeting_imgs.sh [-c city_name_plus_as_space]|[-p picture_folder][-w picture_width]|[-q]|[-h]
 -c: city name, "lower+hutt" for Lower Hutt city in Wellington
     In noraml cases, wttr can detect location from IP
     So it is default to none and wttr automatically look up GeoIP DB.
     Specify city name only if the GeoIP location is not expected.
 -p: folder to pick up picture, default to ~/Pictures
 -w: picture width in cols, default to 32
 -q: quiet mode weather forecast, just for the day, not for every 6hrs
     If current terminal window width is less than 100 cols,
     This mode will automatically activate.
 -h: show this message and exit.
```

Sometimes the GeoIP does not show the exact correct place as I met with Vodaphone landline in Lower Hutt. So `-c` is provided. Please be kindly reminded space shall be replaced with `+`.

## Future Works

Would feel more comfortable to rewrite in Python and add cli options as fetch a random wall-paper from Bing. 

Plan to add quote for the day to randomly show quote from \<Criminal Minds\>.

## Reference

 - [iTerm2 imgcat protocol](https://www.iterm2.com/documentation-images.html)
 - [Tech Blog and Screenshot Demo](https://maxwu.github.io/2017/05/28/Greeting-Shell-script-with-Picture-show-and-Weathre-Forecast/)