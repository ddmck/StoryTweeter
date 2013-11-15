StoryTweeter
============

Accepts a paragraph of text and if it contains over 140 characters splits it in into 135 character chunks and then tweets them in the correct order with an index.


Known Bugs
==========
"\n" will cause the commandline to return only the text previous to it.

Tweets that require more than 10 parts may not send correctly due to the increased length of the appended index. (X/Y) becomes (XX/YY).

Planned Features
================

For tweets longer than 10 parts detect and resize chunks to under 133 characters. Possible to have max of 134 characters for the first 9 parts.
