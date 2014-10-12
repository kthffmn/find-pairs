# Finding Pairs

## Instructions

The attached text file "artist_list.txt", in the `data` folder, contains the favorite musical artists of 1000 users from LastFM. Each line is a list of up to 50 artists, formatted as follows:

```
Radiohead,Pulp,Morrissey,Delays,Stereophonics,Blur,Suede,Sleeper,The La's,Super Furry Animals\n
Band of Horses,Iggy Pop,The Velvet Underground,Radiohead,The Decemberists,Morrissey,Television\n
etc.
```

There are 50,000 band names: 1,000 lists, 50 band names per list. Each list has 1,275 pairs: `n * ( n + 1 ) / 2`

```
  50 + 49 + 48... +  3 +  2 +  1
+  1 +  2 +  3... + 48 + 49 + 50
--------------------------------
  51 + 51 + 51... + 51 + 51 + 51 (50 times)
```

```ruby
n = 50
total_pairs_per_list = n * ( n + 1 ) / 2
# => 1275
```

Using this file as input, this program produces an output file containing a list of pairs of artists which appear TOGETHER in at least fifty different lists. For example, in the above sample, Radiohead and Morrissey appear together twice, but every other pair appears only once.

This solution does not store a list of all possible pairs of bands and instead relies on a bloom filter.