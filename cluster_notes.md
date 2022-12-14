Notes for working on our high performance computing system

## New user account

New users will need to request an account at the below link.

https://shell.cqls.oregonstate.edu/access/

In the "Comments:" section ask to be added to the "vining_lab" unix group so you will be able to use the Vining Lab filespace.
Also ask to be added to the 'hoser' queue for the SGE system so you can have access to the server named 'hoser.'



## Is a software installed?

If a software that you're interested in using is installed on our system and is in your `$PATH` you should be able to type a few characetrs of it's name at the shell and be able to use tab completion to complete it's name.
Remember that Unix is case sensitive, so you may need to try a combination of upper and lower case characters.
If it's installed, you may want to find out where it is installed.
This can be accomplished with the `which` command.

```
$ which bash
/bin/bash
```

Other software on our system may be found at the below location.

```
$ ls /local/cluster/
```

This software may be installed, but it may not be in your `$PATH`.
If it is not in your `$PATH` you can try to call it with a full path.
Alternatively, you can try to add it to your `$PATH`.

```
echo $PATH
export PATH=$PATH:/local/cluster/my_new_program_dir
```


