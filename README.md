# Finding Pairs

## About

The attached text file "artist_list.txt", in the `data` folder, contains the favorite musical artists of 1000 users from [LastFM](http://www.last.fm/). Each line is a list of up to 50 artists, formatted as follows:

```
Radiohead,Pulp,Morrissey,Delays,Stereophonics,Blur,Suede,Sleeper,The La's,Super Furry Animals\n
Band of Horses,Iggy Pop,The Velvet Underground,Radiohead,The Decemberists,Morrissey,Television\n
etc.
```

## Pairings

Given that there are 50 bands per list, each list contains around 1,275 pairs: 

`n * ( n + 1 ) / 2`

```
  50 + 49 + 48... +  3 +  2 +  1
+  1 +  2 +  3... + 48 + 49 + 50
--------------------------------
  51 + 51 + 51... + 51 + 51 + 51 (50 times)
```

```ruby
num_of_lists = 1000

n = 50
total_pairs_per_list = n * ( n + 1 ) / 2
# => 1,275

total_num_of_pairs = total_pairs_per_list * num_of_lists
# => 1,275,000
```

## Approach

Instead of storing over a million arrays with two elements each, representing each pair, this program uses a [counting](http://en.wikipedia.org/wiki/Bloom_filter#Counting_filters) [bloom filter](http://www.jasondavies.com/bloomfilter/) to keep track of all previously stored pairs.

The hash functions were created using the [CityHash gem](https://github.com/nashby/cityhash), a [Google CityHash](https://code.google.com/p/cityhash/) wrapper.

Using the file described above, this program produces an output file containing a list of pairs of artists which appear TOGETHER in at least fifty different lists. For example, in the above sample, Radiohead and Morrissey appear together twice, but every other pair appears only once.

## Setup

From the root of the directory in the terminal, run `bundle install`. Then `rspec` to view RSpec results or `ruby bin/runner.rb` to run the Analyzer class on the LastFM file.
