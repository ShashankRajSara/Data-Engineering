- ps -f
- ps -ef  => To show Daemon Process

- ls -a => Hidden Files
- ls -color => colored list
- ls -d => list Directories with '*/'
- ls -F => add one char of */=>@| to entries (/ for Dir)
- ls -l => inode index number/ long format with permissions
- ls -la => long format including hidden files
- ls -lh => list long format with readable file size
- ls -ls => list with long format with file size
- ls -lt => list with long format with file size, sorted by time, newest first
- ls -r => list in reverse order
- ls -R => list recursively directory tree
- ls -s => list file size
- ls -S => sort by file size
- ls -t => sort by time & date
- ls -X => sort by extension name

- cat <file>
- cd <directory>
- cp <file> <file2>
- history
- fs lq => space used
- fs q => percent of quota used
- mkdir <directory>
- mv <file> <file2> 
- pwd
- rm <file>
- rmdir <directory>
- Ctrl +C => to negate a command that you have enterted
- cd~ => to home directory
- cd~<username> => to home directory of that user
- cd- => to last directory
- wc => word count (no of lines,no of words,no of characters, file name)



- tar (tape archiver) => Archive and extract files

- tar -cf notes.tar notes        => Creating a tar file from notes directory
- tar -czf notes.tar.gz notes    => Archiving the directory and Compressing it
- tar -tf notes.tar              => to show the files inside archive
- tar -xf notes.tar notes        => Unpacking the tar into system directory
- tar -xzf notes.tar.gz notes    => Unpacking the compressed gz tar into system directory



- zip => Compresses files and directories prior to archiving them
- tar => Archives files and directories into a tarball, and can also compress it
- unzip => Unpacks and decompress a zipped archive
- tar => decompresses and unpacks a tar.gz archive


- tr
- curl
- wget
- cut
- find
- sed


- Variables
    #!/bin/sh
    echo "File Name: $0"
    echo "First Parameter : $1"
    echo "Second Parameter : $2"
    echo "Quoted Values: $@"
    echo "Quoted Values: $*"
    echo "Total Number of Parameters : $#"

- Array
    #!/bin/sh
    NAME[0]="Zara"
    NAME[1]="Qadir"
    NAME[2]="Mahnaz"
    NAME[3]="Ayan"
    NAME[4]="Daisy"
    echo "First Index: ${NAME[0]}"
    echo "Second Index: ${NAME[1]}"
    #access all the elements
    echo "First Method: ${NAME[*]}"
    echo "Second Method: ${NAME[@]}"



#!/bin/sh

val=`expr 2 + 2`
echo "Total value : $val"

`expr $a + $b` will give 30
`expr $a - $b` will give -10
`expr $a \* $b` will give 200
`expr $b / $a` will give 2
`expr $b % $a` will give 0
[ $a == $b ]
[ $a != $b ]


[ $a -eq $b ]
[ $a -ne $b ]
[ $a -gt $b ]
[ $a -lt $b ]
[ $a -ge $b ]
[ $a -le $b ]

[ ! false ]
[ $a -lt 20 -o $b -gt 100 ]
[ $a -lt 20 -a $b -gt 100 ]



Checks if the given string operand size is zero; if it is zero length, then it returns true.	[ -z $a ] is not true.
Checks if the given string operand size is non-zero; if it is nonzero length, then it returns true.	[ -n $a ] is not false.
Checks if str is not the empty string; if it is empty, then it returns false.	[ $a ] is not false.



#!/bin/sh

a=0
while [ "$a" -lt 10 ]    # this is loop1
do
   b="$a"
   while [ "$b" -ge 0 ]  # this is loop2
   do
      echo -n "$b "
      b=`expr $b - 1`
   done
   echo
   a=`expr $a + 1`
done



#!/bin/sh

for var1 in 1 2 3
do
   for var2 in 0 5
   do
      if [ $var1 -eq 2 -a $var2 -eq 0 ]
      then
         break 2
      else
         echo "$var1 $var2"
      fi
   done
done

