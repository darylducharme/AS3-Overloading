# Overload for AS3

Tired of reading blogs where people complain about what AS3 is lacking and being inspired by the old [as2lib][] overload functionality I have decided to make my own for AS3 as a proof of concept.

## Note

I tried to allow adding of handlers with reflection/introspection pulling the method signature. Unfortunately I could not get access to the method signature through describe type, even after playing with different avmplus parameters and looking at [tamarin][] code.

## TODOs and To Address ##
* My be good to be able to turn off numerical explicitness on a per handler basis.
	* Need to write a test that will break the current system to see if it is necessary.

[tamarin]:http://hg.mozilla.org/tamarin-central/file/fbecf6c8a86f
[as2lib]:http://as2lib.svn.sourceforge.net/viewvc/as2lib/trunk/main/src/org/as2lib/
