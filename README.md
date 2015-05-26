# Go small or go home

Lets save the interweb, and make all binaries small. This tiny (1.1MB) Docker image
is a containerized [upx](http://upx.sourceforge.net).

## Usage


You can compress your binary file as:

```
$ docker run -v $PWD:/data lalyos/upx mybinary
```

## Go for even smaller

I was playing with the docker binary itself, and got it compressed under **1.5MB**.
Shouldn’t it be the official release ;)

You can use all the available upx options, so if ypo have some time,
and want to create the smallest size, use `--best --ultra-brute` options:

```
$ docker run --rm -v $PWD:/data  lalyos/upx -k --best --ultra-brute docker

                       Ultimate Packer for eXecutables
                          Copyright (C) 1996 - 2013
UPX 3.91        Markus Oberhumer, Laszlo Molnar & John Reiser   Sep 30th 2013

        File size         Ratio      Format      Name
   --------------------   ------   -----------   -----------
   7474608 ->   1454080   19.45%   Mach/AMD64    docker

Packed 1 file.

```

The `-k` options is for keeping a backup from the original binary.



## tl;dr

- It is statically built with Alpine linux
- compressed by itdelf (eat your own dogfood)
- added into a [custom scratch](https://github.com/lalyos/docker-scratch-chmx)

## TODO

If I’m getting too bored (unlikely in the coming weeks) i might create an
ordinary Alpine package for upx.
