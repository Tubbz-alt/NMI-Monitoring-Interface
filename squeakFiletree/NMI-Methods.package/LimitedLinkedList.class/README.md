A LimitedLinkedList is an LinkedList wich can contain upto 'capacity' elements. When the length is 'capacity' and a new element 'x' is added, then:
--------------
1] the oldest element is removed.
2] the new element 'x' is added. 
--------------

This data structure is defined to keep a buffer of last data which automatically drops old ones. 

----- Example ----------------
ll := LimitedLinkedList new: 3.
ll add: 1.
ll add: 2.
ll add: 3.
ll explore.   "=> 1 2 3"
ll add: 4.
ll explore.   "=> 2 3 4"
"Accessing data examples."
ll data.
ll data first.
ll data last.
-----------------------------------


Instance Variables
	capacity:		<Number>
	data: <LinkedList>  		

capacity 
	- xxxxx
