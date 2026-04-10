# This file is to test the best way to run system commands in an R-file instead of CLI

#The most basic option is to use system() or system2() --> this runs the command as a string
echo("Hello") #This gives an error as the function cannot be found
#echo "Hello"

system2(command = "pwd")
system2("pwd")
# Both ways work, lets try it with a command with arguments

system2(command = "echo \"Hello\"")
#Thus, using an argument to the command does not work, it appears to to " as a unexpected symbol
#Even when trying to escape the symbol by using \ we cannot get it to work
#When using the LDAK software, we need to use arguments, so this is not a viable option


#Another option is using the sys package
library(sys)

exec_wait(echo "Hello")
exec_wait(echo, args = "Hello")
#this also does not seem to work