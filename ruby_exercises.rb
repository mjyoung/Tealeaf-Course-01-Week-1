my_array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

# 1. Use the "each" method of Array to iterate over [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], and print out each value.

my_array.each { |value| puts value }

# 2. Same as above, but only print out values greater than 5.

my_array.each { |value| puts value if value > 5 }   # [6, 7, 8, 9, 10]

# 3. Now, using the same array from #2, use the "select" method to extract all odd numbers into a new array.

new_array = my_array.select { |value| value % 2 != 0 }  # [1, 3, 5, 7, 9]
### alternatively:  my_array.select { |value| value.odd? }

# 4. Append "11" to the end of the array. Prepend "0" to the beginning.

new_array.insert(0,0)   # insert(index.obj)  [0, 1, 3, 5, 7, 9]
                        # new_array.unshift(0)  unshift adds a value to the beginning
new_array.insert(-1,11) # alternatively, new_array << 11, or new_array.push(11)  [0, 1, 3, 5, 7, 9, 11]  


# 5. Get rid of "11". And append a "3".

new_array.delete(11)  # [0, 1, 3, 5, 7, 9]
new_array.push(3)     # [0, 1, 3, 5, 7, 9, 3]

# 6. Get rid of duplicates without specifically removing any one value. 

new_array.uniq!       # [0, 1, 3, 5, 7, 9]

# 7. What's the major difference between an Array and a Hash?

### The major difference is that an array uses Integers as its index value, 
### while a Hash can use any object type as its key

# 8. Create a Hash using both Ruby 1.8 and 1.9 syntax.

my_18_hash = { :font_size => 10, :font_family => "Arial" } # need to use hash rockets
my_19_hash = { font_size: 10, font_family: "Arial" }       # no need for hash rockets with symbols

# Suppose you have a h = {a:1, b:2, c:3, d:4}

# 9. Get the value of key "b".

h[:b]

# 10. Add to this hash the key:value pair {e:5}

h[:e] = 5

# 13. Remove all key:value pairs whose value is less than 3.5

h.select! { |key, value| value < 3.5 }

# 14. Can hash values be arrays? Can you have an array of hashes? (give examples)

### Yes, hash values can be arrays. Example below:

array1 = [0,1]
array2 = [2,3]
hash1 = { array1: array1, array2: array2 }  # {:array1=>[0, 1], :array2=>[2, 3]}

### Yes, you can have an array of hashes. Example below:

hash_dogs = { noise: "bark", enemy: "cats" }
hash_cats = { noise: "meow", enemy: "dogs" }
array_pets = [ hash_dogs, hash_cats ]
# [{:noise=>"bark", :enemy=>"cats"}, {:noise=>"meow", :enemy=>"dogs"}]

# 15. Look at several Rails/Ruby online API sources and say which one you like best and why.

### For Ruby, http://ruby-doc.org's documentation has been extremely helpful
### I have zero experience with rails, but http://api.rubyonrails.org/ looks 
### relatively comprehensive.
### Offline documentation for Rails 4: https://github.com/passion8/Rails-4-offline-documentation

### While not API, this site seems like it would be useful in that it has 
### detailed examples on how to do common tasks in Rails: http://guides.rubyonrails.org/
