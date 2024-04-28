# bash-synthesizer

### A simple bash script that plays a melody from an input string of notes.

#### Audio by courtesy of [fuhton/piano-mp3](https://github.com/fuhton/piano-mp3).

### Usage:
You will need ffmpeg (ffplay) and bc (Basic Calculator) installed on your system.
You provide notes as an argument, one after another without spaces. Underscore means tenuto, so holding a note for another 16th.
```sh
./synth.sh C3__E3G3
```

Both b (flat) and # (sharp) are supported. Remember, that to use # you will have to enclose your sequence of notes in quotation marks.
```sh
./synth.sh "D4_F#4_Ab5_A5"