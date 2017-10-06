Coding Kata for Pillar Technology
---------------------------------


**BabySitter**
This kata simulates a babysitter working and getting paid for one night. The rules are pretty straight forward.

The babysitter:

- starts no earlier than 5:00PM leaves no later than 4:00AM 
- gets paid $12/hour from start-time to bedtime 
- gets paid $8/hour from bedtime to midnight
- gets paid $16/hour from midnigt to end of job 
- gets paid for full hours (no fractional hours)

----------

(Note: program will not calculate fractional hours and will remove any amounts to right of decimal.)

Assuming you have ruby installed, follow this checklist to run the program: 

 1. clone repo: 
 2. cd into repo
 3. run `irb -r ./lib/kata_baby_sitter.rb`
 4. to run properly please enter each hour in the following format -> "8pm"
 5. run `KataBabySitter.new(start_time, end_time, bed_time).calc_payment` 
    
To run test suite. 

 1. ensure you are in root of repo
 2. run `bundle install`
 3. run `rspec`
