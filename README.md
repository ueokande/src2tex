SrC2TeX
=======

Src2teX is a script that bind source codes to a document file such as PDF, DVI, and HTML.


Usage
-----
To generate a tex file, run a command like the following:

    $ src2tex /path/to/source_tree/
    
then a tex file `source_tree.txt` is generated.  You can create a document file from .tex file.  For example, PDF is created as following command:

    $ pdflatex source_tree.txt


License and copylight
---------------------
Copyright (c) 2012 Shin'ya Ueoka.  Src2TeX is licensed under MIT lisence.