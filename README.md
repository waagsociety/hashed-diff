# hashed-diff
A memory efficient diff script for large files, implemented with [xxHash](https://github.com/Cyan4973/xxHash).

The hashed-diff ruby script is a reasonably fast, memory efficient script that wraps diff for very large files (4Gb).

The script uses the very fast xxhash to create temporary files with hashes for each individual line.
Then it applies diff to these hashed files.
Finally the script transforms the diff output to include the original lines.

Dependencies:

gem install xxhash
