A a class that is here just to remember us stuff that is to be done. 

We enter SqueakSource online. Passwords have been removed. 

----------- Sequence of commands to try --------------------

mm getHostsList .
mm := MMonit new. 
mm setTheCookie . 
mm authenticateUser:  'xxx' password: 'xxx'.
tmp := mm getHostsList .
tmp := mm getGroupsList.
mm unAuthenticate .

-----------------------------------------------------------------------------

========= TODO ==============
. getHostLsit must return a list of Host objects.
. find a way to get the list of groupNames

===========================





Instance Variables
