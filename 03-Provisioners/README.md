If you need to do some initial setup on your instances, then provisioners let you upload files, run shell scripts, or install and trigger other software like configuration management tools, etc.


For CM tools you should use terraform provisioning

Provisioners can also be defined that run only during a destroy operation. These are useful for performing system cleanup, extracting data, etc.