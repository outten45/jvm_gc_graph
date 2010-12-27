## JVM GC Graph

Simple gem that creates a static HTML page that uses Google's 
Interactive Charts to display JVM heap usage output to a file.  In
order of this to work, you need to pass the following options to the
JVM:

    -XX:-PrintGCTimeStamps -XX:-PrintGCDetails -Xloggc:<location of log file>

Here is an example:

  java -XX:-PrintGCTimeStamps -XX:-PrintGCDetails -Xloggc:memory.log MyApp

## Installation

    gem install jvm_gc_graph

## Usage

    jvm_gc_graph -f /path/to/memory_gc.log -o /www/gc_log.html

1) Looks at /path/to/memory_gc.log which contains the gc log
2) Writes the result to the gc_log.html file.

## Other

For a much richer tool, try [GCViewer](http://www.tagtraum.com/gcviewer.html).

## License

Copyright (c) 2010 Richard Outten

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
