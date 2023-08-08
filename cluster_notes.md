Notes for working on our high performance computing system

## New user account

New users will need to request an account at the below link.

https://shell.cqls.oregonstate.edu/access/

In the "Comments:" section ask to be added to the "vining_lab" unix group so you will be able to use the Vining Lab filespace.
Also ask to be added to the 'hoser' queue for the SGE system so you can have access to the server named 'hoser.'

## Primary group for a user

Each user may be a member of several unix groups, but each user will have one primary group.
A user can query their group membership as follows.

```
$ groups
vining_lab grunwald_lab sagar_lab oncore
```

Note that this user belongs to 4 groups and the first group, 'vining_lab', is their primary group.
This becomes important when the user wants to share materials they created.
The files and directories created by the user will have a single group associated with them.
This can be seen as follows.

```
$ ls -l
total 972
-rw-r--r--   1 knausb vining_lab    727 Oct 31  2016 20161031_du.txt
-rw-r--r--   1 knausb vining_lab   2462 Jun 28  2016 b2ferr
-rw-r--r--   1 knausb vining_lab   2027 Jun 28  2016 b2fout
drwxr-xr-x  55 knausb vining_lab   4096 Oct 30  2022 bin/
...
```

Here, the username of the owner is 'knausb' and the group is 'vining_lab'.
The 'group' permissions here will only be relevant to the file or directory's single group.
The 'group' for files and directories created by a user will be assigned to a user's primary group.
The owner can change the group that a file or directory belongs to as follows.

```
chgrp sagar_lab file1
```

This will now allow the owner to share 'file1' with the members of 'sagar_lab' but this will also prevent sharing with members of 'vining_lab'.


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


