# Coding Challenge

## Instructions

The attached text file "artist_list.txt", in the `data` folder, contains the favorite musical artists of 1000 users from LastFM. Each line is a list of up to 50 artists, formatted as follows:

```
Radiohead,Pulp,Morrissey,Delays,Stereophonics,Blur,Suede,Sleeper,The La's,Super Furry Animals\n
Band of Horses,Iggy Pop,The Velvet Underground,Radiohead,The Decemberists,Morrissey,Television\n
etc.
```

Using this file as input, this program produces an output file containing a list of pairs of artists which appear TOGETHER in at least fifty different lists. For example, in the above sample, Radiohead and Morrissey appear together twice, but every other pair appears only once.

This solution does not store a list of all possible pairs of bands and instead relies on a bloom filter.