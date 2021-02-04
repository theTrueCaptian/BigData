Register 'tokenize.py' using jython as myfuncs; 

lines = LOAD '/user/cloudera/inputhwk4.txt' AS (line:chararray);
words = FOREACH lines GENERATE FLATTEN(myfuncs.tokenize(line)) as word;
grouped = GROUP words BY myfuncs.groupByLowercase(word);
wordcount = FOREACH grouped GENERATE group as word, COUNT(words);
wordcount = filter wordcount by myfuncs.isWordInSearchTerms(word)!=-1;
DUMP wordcount;
/*
*/





