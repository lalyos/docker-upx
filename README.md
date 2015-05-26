# Go small or go home

Lets save the interweb, and make all binaries small. This tiny () Docker image
is a containerized [upx](http://upx.sourceforge.net).

## Usage


You can compress your binary file as:

```
docker run -v $PWD:/release lalyos/upx mybinary
```

##


## tl;dr

- It is statically built with Alpine linux
- compressed by itdelf (eat your own dogfood)
- added into a [custom scratch](https://github.com/lalyos/docker-scratch-chmx)

## TODO

If I’m getting too bored (unlikely in the coming weeks) i might create an
ordinary Alpine package for upx.
