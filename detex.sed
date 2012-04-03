# Edit TeXisms in the .bbl output, to make it HTML-ready
/% *$/{N;s/% *\n//;}
s/[{}]//g
s,\([^/]\)~,\1 ,g
s,&,&amp;,g
s,\\ss,ß,g
s,\\'a,á,g
s,\\'e,é,g
s,\\^o,ô,g
s+\\,c+ç+g
s,\\"o,ö,g
s,\\"u,ü,g
s,--,—,g
s,\\ , ,g
