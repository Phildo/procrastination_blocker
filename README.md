Route2Local
=======================

Shell script to block websites (re-route them to localhost) on mac

NOTE- MUST BE SUPER USER TO FUNCTION. Also, this is kinda doing some weird stuff. So if you don't trust me (you shouldn't), look in the code yourself/ don't use this blocker.

assuming it's already executable (chmod +x r2l) and on your PATH...

To set blocked websites:
by argument:

    sudo r2l facebook.com reddit.com news.ycombinator.com
    
by file:

    sudo r2l -f myblockedwebpages.txt

by env variable: (nice to just set it in .bashrc or something)

    sudo R2L_NAMES=$R2L_NAMES r2l -e #note- needs to explicitly pass the R2L_NAMES env variable to sudo if not already done
    
the file/env variable must be of the following format (comma separated domains):

    facebook.com,reddit.com,news.ycombinator.com,youtube.com


To unblock:

    sudo r2l -u
    
    
Unfortunately, you cannot currently additively block/remove blocks. It's either "hey! block all these!" or "unblock everything!". Attempts to add another domain will result in error.

If I feel motivated in the future, I might add that functionality. And hey, now I can use this tool so I can actually do that!
    
