# Prompt-Engineering-Database
A SQL Database Backend for an LLM Workflow System - ChainForge

The main goal	in	this	project	is	to	reverse-engineer	the	relational	
database	at	the	heart	of	ChainForge,	so	as	to	better	understand	the	crucial	role	of	
the	backend	database	in	the	enterprise	application.

The database schema can allow for multiple prompt engineering node configurations such as the following:

![image](https://github.com/user-attachments/assets/e014a294-d6f8-4cce-868a-bd4bd1974d1e)


## How is an LLM Conversation Structured?

A	key	part	of	an	LLM-based	application	is	the	management	of	data	and	of	where	
and	how	it	flows.	An	application	like this	manages	the	data flow	into	and	out	of	its	core LLM.	For	instance,	when	you	
use	ChatGPT,	your	conversation	is	more	than	a	sequence	of	independent	prompt	
and	continuation	pairs.	Rather,	each	successive	prompt	from	you	must	implicitly	
include	the	whole	conversation	so	far	as	a	tacit	context	to	the	model,	if	the	LLM	is	
to	remember	what	you	have	been	talking	about	and	to	use	that	data	accordingly. We	can	think	of	the	LLM	as	a	parameterized	blackbox,	just	one	
component	in	a	complex	workflow	that	may	contain	many	different	nodes,	 from	
data	 stores	 to	 prompt	 constructors	 (to	 build	 the	 prompts	 given	 to	 the	 LLM)	 to	
output	collectors	and	evaluators	(to	analyze	what	the	LLM	produces	as	replies).	

## ChainForge

ChainForge	(https://github.com/ianarawjo/ChainForge) is	 a	 flexible	 and	 very	 useful	 manager	 for	 LLM	 workflows.	
Designed		by	Ian	Arawio at	Harvard	university,	it is	freely	available	for	online	use	
as	 a	 web	 application	 at	 www.chainforge.ai,	 where	 it	 provides	 a	 graphical	 UI	 for	
constructing	 workflows	 as	 graphs	 of	 connected	 nodes.	 These	 nodes	 vary	 in	
function,	 and	 each	 provides	 a	 small	 part	 of	 the	 overall	 application.	Some	 nodes	
simply	 store	 data,	 as	 a	 set	 of	 values,	 or	 as	 a	 table	 of	 rows	 and	 columns.	Others	
construct	prompts	from	this	data	to	feed	into	LLMs,	while	some	 take	the	outputs	
of	these	prompt	nodes and	analyze	them,	before	feeding	their analyses	elsewhere	
to e.g.,	be visualized.	 Each	 node	is	 configurable	 to	 suit	 the	 needs	 of	a	workflow	
designer.	 For	 instance,	 a	 prompt	 node	 can	 be	 configured	 to	 feed	 into	 multiple	
LLMs,	so	that	the	node	produces	one	output	for	each	LLM.	Nodes	that	turn	single	
inputs	into	multiple outputs	allow	a	workflow	to	achieve	combinatorial	effects,	so	
that	a	single	input	at	the	start	of	the	workflow	can	produce	many	outputs	at	the	
far	end.

Although	ChainForge	is	free	to	use,	it	is still an	enterprise	application	of	sorts.	
It	must	support	many	different	users	at	once,	and	each	user	may	create	and	save	
multiple	 workflows.	 These	flows	 have	 to	 be	 stored	 somewhere,	 to	 permit	 easy	
loading	and	saving	of	the user’s	work.	There	is	where	a	backend	database comes	
in.	Each	workflow	and	its	various	parts must	be	persistently	stored	in	a	database	
so	that	these	parts	can	be	queried	and	modified	as	needed.	A	relational	database
makes	 the	most	 sense	for this	 datastore,	 since	 each	workflow	node	 has	 a	 welldefined	schema,	just	as	each	flow	is itself a	well-defined	data	structure	made out	
of	these	parts. 
