procrastination_blocker
=======================

Shell script to block websites (re-route them to localhost) on mac

NOTE- MUST BE SUPER USER TO FUNCTION. Also, this is kinda doing some weird stuff. So if you don't trust me (you shouldn't), look in the code yourself/ don't use this blocker.

assuming it's already executable (chmod +x blocker.sh) and in your current directory...

To set blocked websites:
by argument:

    sudo ./blocker.sh facebook.com reddit.com news.ycombinator.com
    
by file:

    sudo ./blocker.sh -f myblockedwebpages.txt
    
the file must be of the following format (newline separated domains):

    facebook.com
    reddit.com
    news.ycombinator.com
    

To unblock:

    sudo ./blocker -u
    
    
Unfortunately, you cannot currently additively block/remove blocks. It's either "hey! block all these!" or "unblock everything!". Attempts to add another domain will result in error.

If I feel motivated in the future, I might add that functionality. And hey, now I can use this tool so I can actually do that!
    
