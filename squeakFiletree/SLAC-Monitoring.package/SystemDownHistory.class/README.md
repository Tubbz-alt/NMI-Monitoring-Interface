A SystemDownHistory is buffer of SystemDownStatus objects. 

It is a subclass of LimitedLinkedList which realizes the buffer structure with limited depth.

A new SystemDownStatus enter the buffer only if something is changed respect to the last stored status. For example, a new host is gone down, a service restarted working etc. 

Instance Variables
